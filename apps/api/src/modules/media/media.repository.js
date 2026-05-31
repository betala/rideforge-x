import { pool } from '../../db/pool.js';

const toApi = (row) => ({
  id: row.id,
  ownerType: row.owner_type,
  ownerId: row.owner_id,
  storagePath: row.storage_path,
  contentType: row.content_type,
  url: row.url,
  caption: row.caption,
  createdAt: row.created_at,
});

export class MediaRepository {
  async create(userId, intent) {
    const result = await pool.query(
      `insert into media_items
       (id, user_id, owner_type, owner_id, storage_path, content_type, url)
       values ($1,$2,$3,$4,$5,$6,$7)
       returning *`,
      [
        intent.mediaId,
        userId,
        intent.ownerType,
        intent.ownerId,
        intent.storagePath,
        intent.contentType,
        intent.uploadUrl,
      ],
    );
    return toApi(result.rows[0]);
  }

  async list(userId, ownerType, ownerId) {
    const result = await pool.query(
      `select * from media_items
       where user_id=$1 and owner_type=$2 and owner_id=$3
       order by created_at desc`,
      [userId, ownerType, ownerId],
    );
    return result.rows.map(toApi);
  }
}

