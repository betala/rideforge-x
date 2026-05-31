import { FirebaseStorageService } from '../../services/firebaseStorageService.js';
import { MediaRepository } from './media.repository.js';

export class MediaService {
  constructor(repository = new MediaRepository(), storage = new FirebaseStorageService()) {
    this.repository = repository;
    this.storage = storage;
  }

  async createUploadIntent(userId, data) {
    const intent = await this.storage.createUploadIntent({ userId, ...data });
    const mediaItem = await this.repository.create(userId, { ...data, ...intent });
    return { ...mediaItem, uploadUrl: intent.uploadUrl };
  }

  list(userId, ownerType, ownerId) {
    return this.repository.list(userId, ownerType, ownerId);
  }
}

