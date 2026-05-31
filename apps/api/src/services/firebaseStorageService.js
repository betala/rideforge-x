import { v4 as uuid } from 'uuid';

import { env } from '../config/env.js';

export class FirebaseStorageService {
  async createUploadIntent({ userId, ownerType, ownerId, fileName, contentType }) {
    const mediaId = uuid();
    const storagePath = `users/${userId}/${ownerType}/${ownerId}/${mediaId}-${fileName}`;

    return {
      mediaId,
      storagePath,
      contentType,
      bucket: env.firebaseStorageBucket,
      uploadUrl: `firebase://${env.firebaseStorageBucket}/${storagePath}`,
    };
  }
}

