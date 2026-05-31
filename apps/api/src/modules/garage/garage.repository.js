import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  nickname: row.nickname,
  make: row.make,
  model: row.model,
  year: row.year,
  vin: row.vin,
  odometerKm: row.odometer_km,
  purchaseDate: row.purchase_date,
  imageUrl: row.image_url,
  createdAt: row.created_at,
  updatedAt: row.updated_at,
});

export class GarageRepository {
  async list(userId) {
    const result = await pool.query(
      `select * from motorcycles where user_id = $1 and deleted_at is null order by created_at desc`,
      [userId],
    );
    return result.rows.map(toApi);
  }

  async findById(userId, id) {
    const result = await pool.query(
      `select * from motorcycles where user_id = $1 and id = $2 and deleted_at is null`,
      [userId, id],
    );
    return result.rows[0] ? toApi(result.rows[0]) : null;
  }

  async create(userId, data) {
    const id = data.id ?? uuid();
    const result = await pool.query(
      `insert into motorcycles
       (id, user_id, nickname, make, model, year, vin, odometer_km, purchase_date, image_url)
       values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
       returning *`,
      [
        id,
        userId,
        data.nickname,
        data.make,
        data.model,
        data.year,
        data.vin ?? null,
        data.odometerKm ?? 0,
        data.purchaseDate ?? null,
        data.imageUrl ?? null,
      ],
    );
    return toApi(result.rows[0]);
  }

  async update(userId, id, data) {
    const current = await this.findById(userId, id);
    if (!current) return null;

    const merged = { ...current, ...data };
    const result = await pool.query(
      `update motorcycles
       set nickname=$3, make=$4, model=$5, year=$6, vin=$7, odometer_km=$8,
           purchase_date=$9, image_url=$10, updated_at=now()
       where user_id=$1 and id=$2 and deleted_at is null
       returning *`,
      [
        userId,
        id,
        merged.nickname,
        merged.make,
        merged.model,
        merged.year,
        merged.vin ?? null,
        merged.odometerKm ?? 0,
        merged.purchaseDate ?? null,
        merged.imageUrl ?? null,
      ],
    );
    return toApi(result.rows[0]);
  }

  async softDelete(userId, id) {
    await pool.query(
      `update motorcycles set deleted_at = now(), updated_at = now() where user_id = $1 and id = $2`,
      [userId, id],
    );
  }
}

