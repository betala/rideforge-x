import { MaintenanceRepository } from './maintenance.repository.js';

export class MaintenanceService {
  constructor(repository = new MaintenanceRepository()) {
    this.repository = repository;
  }

  list(userId, motorcycleId) {
    return this.repository.list(userId, motorcycleId);
  }

  create(userId, motorcycleId, data) {
    return this.repository.create(userId, motorcycleId, data);
  }

  complete(userId, id, data) {
    return this.repository.complete(userId, id, data);
  }
}

