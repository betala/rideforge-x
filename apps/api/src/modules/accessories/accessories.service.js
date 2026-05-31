import { AccessoriesRepository } from './accessories.repository.js';

export class AccessoriesService {
  constructor(repository = new AccessoriesRepository()) {
    this.repository = repository;
  }

  list(userId, motorcycleId) {
    return this.repository.list(userId, motorcycleId);
  }

  create(userId, motorcycleId, data) {
    return this.repository.create(userId, motorcycleId, data);
  }
}

