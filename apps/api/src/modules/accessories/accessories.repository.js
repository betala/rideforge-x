import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  motorcycleId: row.motorcycle_id,
  name: row.name,
  brand: row.brand,
  category: row.category,
  installedOn: row.installed_on,
  cost: row.cost,
  currency: row.currency,
  warrantyUntil: row.warranty_until,
  notes: row.notes,
});

export class AccessoriesRepository {
  async list(userId, motorcycleId) {
    const result = await pool.query(
      `select a.* from accessories a
       join motorcycles m on m.id = a.motorcycle_id
       where m.user_id = $1 and a.motorcycle_id = $2
       order by a.created_at desc`,
      [userId, motorcycleId],
    );
    return result.rows.map(toApi);
  }

  async create(userId, motorcycleId, data) {
    const result = await pool.query(
      `insert into accessories
       (id, motorcycle_id, name, brand, category, installed_on, cost, currency, warranty_until, notes)
       select $1, m.id, $3, $4, $5, $6, $7, $8, $9, $10
       from motorcycles m where m.user_id = $2 and m.id = $11
       returning *`,
      [
        uuid(),
        userId,
        data.name,
        data.brand ?? null,
        data.category,
        data.installedOn ?? null,
        data.cost ?? null,
        data.currency ?? null,
        data.warrantyUntil ?? null,
        data.notes ?? null,
        motorcycleId,
      ],
    );
    return toApi(result.rows[0]);
  }
}

