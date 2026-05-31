import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  motorcycleId: row.motorcycle_id,
  name: row.name,
  startDate: row.start_date,
  endDate: row.end_date,
  waypoints: row.waypoints,
  preferences: row.preferences,
  routeGeometry: row.route_geometry,
  distanceKm: row.distance_km,
  etaMinutes: row.eta_minutes,
});

export class TouringRepository {
  async list(userId) {
    const result = await pool.query(
      `select * from tour_plans where user_id = $1 order by created_at desc`,
      [userId],
    );
    return result.rows.map(toApi);
  }

  async create(userId, data) {
    const result = await pool.query(
      `insert into tour_plans
       (id, user_id, motorcycle_id, name, start_date, end_date, waypoints, preferences)
       values ($1,$2,$3,$4,$5,$6,$7,$8)
       returning *`,
      [
        uuid(),
        userId,
        data.motorcycleId ?? null,
        data.name,
        data.startDate ?? null,
        data.endDate ?? null,
        JSON.stringify(data.waypoints ?? []),
        JSON.stringify(data.preferences ?? {}),
      ],
    );
    return toApi(result.rows[0]);
  }

  async enrichRoute(userId, id, route) {
    const result = await pool.query(
      `update tour_plans
       set route_geometry=$3, distance_km=$4, eta_minutes=$5, updated_at=now()
       where user_id=$1 and id=$2
       returning *`,
      [userId, id, route.routeGeometry, route.distanceKm, route.etaMinutes],
    );
    return toApi(result.rows[0]);
  }
}

