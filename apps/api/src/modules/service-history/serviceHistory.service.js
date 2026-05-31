import { ServiceHistoryRepository } from './serviceHistory.repository.js';

export class ServiceHistoryService {
  constructor(repository = new ServiceHistoryRepository()) {
    this.repository = repository;
  }

  list(userId, motorcycleId) {
    return this.repository.list(userId, motorcycleId);
  }

  create(userId, motorcycleId, data) {
    return this.repository.create(userId, motorcycleId, data);
  }
}

