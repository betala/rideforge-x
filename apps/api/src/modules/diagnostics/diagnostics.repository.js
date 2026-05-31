import { v4 as uuid } from 'uuid';

import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  motorcycleId: row.motorcycle_id,
  severity: row.severity,
  confidence: Number(row.confidence),
  likelyCauses: row.likely_causes,
  recommendedActions: row.recommended_actions,
  safeToRide: row.safe_to_ride,
  createdAt: row.created_at,
});

export class DiagnosticsRepository {
  async create(userId, data, analysis) {
    const result = await pool.query(
      `insert into diagnostic_reports
       (id, user_id, motorcycle_id, symptoms, obd_codes, severity, confidence,
        likely_causes, recommended_actions, safe_to_ride)
       values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)
       returning *`,
      [
        uuid(),
        userId,
        data.motorcycleId,
        JSON.stringify(data.symptoms ?? []),
        JSON.stringify(data.obdCodes ?? []),
        analysis.severity,
        analysis.confidence,
        JSON.stringify(analysis.likelyCauses),
        JSON.stringify(analysis.recommendedActions),
        analysis.safeToRide,
      ],
    );
    return toApi(result.rows[0]);
  }
}

