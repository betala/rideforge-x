import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const rideToApi = (row) => ({
  id: row.id,
  name: row.name,
  tourPlanId: row.tour_plan_id,
  startsAt: row.starts_at,
  visibility: row.visibility,
  inviteCode: row.invite_code,
});

export class GroupRidesRepository {
  async create(userId, data) {
    const id = uuid();
    const inviteCode = `RF-${Math.random().toString(36).slice(2, 6).toUpperCase()}`;
    const result = await pool.query(
      `insert into group_rides (id, owner_user_id, tour_plan_id, name, starts_at, visibility, invite_code)
       values ($1,$2,$3,$4,$5,$6,$7)
       returning *`,
      [id, userId, data.tourPlanId ?? null, data.name, data.startsAt, data.visibility ?? 'invite_only', inviteCode],
    );
    await this.join(userId, id);
    return rideToApi(result.rows[0]);
  }

  async join(userId, groupRideId) {
    await pool.query(
      `insert into group_ride_members (group_ride_id, user_id)
       values ($1,$2)
       on conflict (group_ride_id, user_id) do nothing`,
      [groupRideId, userId],
    );
  }

  async recordLocation(userId, groupRideId, data) {
    const result = await pool.query(
      `insert into group_ride_locations
       (id, group_ride_id, user_id, lat, lng, speed_kph, heading, recorded_at)
       values ($1,$2,$3,$4,$5,$6,$7,$8)
       returning *`,
      [uuid(), groupRideId, userId, data.lat, data.lng, data.speedKph ?? null, data.heading ?? null, data.recordedAt],
    );
    return result.rows[0];
  }

  async liveLocations(groupRideId) {
    const result = await pool.query(
      `select distinct on (user_id) user_id as "memberId", lat, lng, speed_kph as "speedKph",
              heading, recorded_at as "recordedAt"
       from group_ride_locations
       where group_ride_id = $1
       order by user_id, recorded_at desc`,
      [groupRideId],
    );
    return result.rows;
  }
}

