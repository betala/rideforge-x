import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  motorcycleId: row.motorcycle_id,
  title: row.title,
  category: row.category,
  dueDate: row.due_date,
  dueOdometerKm: row.due_odometer_km,
  priority: row.priority,
  status: row.status,
  completedAt: row.completed_at,
  completedOdometerKm: row.completed_odometer_km,
  notes: row.notes,
});

export class MaintenanceRepository {
  async list(userId, motorcycleId) {
    const result = await pool.query(
      `select mt.* from maintenance_tasks mt
       join motorcycles m on m.id = mt.motorcycle_id
       where m.user_id = $1 and mt.motorcycle_id = $2
       order by coalesce(mt.due_date, now()) asc`,
      [userId, motorcycleId],
    );
    return result.rows.map(toApi);
  }

  async create(userId, motorcycleId, data) {
    const result = await pool.query(
      `insert into maintenance_tasks
       (id, motorcycle_id, title, category, due_date, due_odometer_km, priority, status, notes)
       select $1, m.id, $3, $4, $5, $6, $7, $8, $9
       from motorcycles m where m.user_id = $2 and m.id = $10
       returning *`,
      [
        uuid(),
        userId,
        data.title,
        data.category,
        data.dueDate ?? null,
        data.dueOdometerKm ?? null,
        data.priority ?? 'medium',
        data.status ?? 'open',
        data.notes ?? null,
        motorcycleId,
      ],
    );
    return toApi(result.rows[0]);
  }

  async complete(userId, id, data) {
    const result = await pool.query(
      `update maintenance_tasks mt
       set status='completed', completed_at=$3, completed_odometer_km=$4,
           notes=coalesce($5, notes), updated_at=now()
       from motorcycles m
       where m.id = mt.motorcycle_id and m.user_id = $1 and mt.id = $2
       returning mt.*`,
      [userId, id, data.completedAt ?? new Date().toISOString(), data.odometerKm ?? null, data.notes ?? null],
    );
    return toApi(result.rows[0]);
  }
}
