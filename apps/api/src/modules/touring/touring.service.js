import { MapboxService } from '../../services/mapboxService.js';
import { TouringRepository } from './touring.repository.js';

export class TouringService {
  constructor(repository = new TouringRepository(), mapbox = new MapboxService()) {
    this.repository = repository;
    this.mapbox = mapbox;
  }

  list(userId) {
    return this.repository.list(userId);
  }

  create(userId, data) {
    return this.repository.create(userId, data);
  }

  async optimizeRoute(userId, id, data) {
    const route = await this.mapbox.optimizeRoute(data);
    return this.repository.enrichRoute(userId, id, route);
  }
}

