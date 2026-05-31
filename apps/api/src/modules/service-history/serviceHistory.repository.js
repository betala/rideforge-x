import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  motorcycleId: row.motorcycle_id,
  serviceDate: row.service_date,
  odometerKm: row.odometer_km,
  provider: row.provider,
  summary: row.summary,
  cost: row.cost,
  currency: row.currency,
  invoiceMediaId: row.invoice_media_id,
});

export class ServiceHistoryRepository {
  async list(userId, motorcycleId) {
    const result = await pool.query(
      `select sr.* from service_records sr
       join motorcycles m on m.id = sr.motorcycle_id
       where m.user_id = $1 and sr.motorcycle_id = $2
       order by sr.service_date desc`,
      [userId, motorcycleId],
    );
    return result.rows.map(toApi);
  }

  async create(userId, motorcycleId, data) {
    const result = await pool.query(
      `insert into service_records
       (id, motorcycle_id, service_date, odometer_km, provider, summary, cost, currency, invoice_media_id)
       select $1, m.id, $3, $4, $5, $6, $7, $8, $9
       from motorcycles m where m.user_id = $2 and m.id = $10
       returning *`,
      [
        uuid(),
        userId,
        data.serviceDate,
        data.odometerKm,
        data.provider ?? null,
        data.summary,
        data.cost ?? null,
        data.currency ?? null,
        data.invoiceMediaId ?? null,
        motorcycleId,
      ],
    );
    return toApi(result.rows[0]);
  }
}

