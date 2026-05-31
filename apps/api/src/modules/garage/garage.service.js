import { GarageRepository } from './garage.repository.js';

export class GarageService {
  constructor(repository = new GarageRepository()) {
    this.repository = repository;
  }

  list(userId) {
    return this.repository.list(userId);
  }

  create(userId, data) {
    return this.repository.create(userId, data);
  }

  update(userId, id, data) {
    return this.repository.update(userId, id, data);
  }

  async remove(userId, id) {
    await this.repository.softDelete(userId, id);
  }
}

