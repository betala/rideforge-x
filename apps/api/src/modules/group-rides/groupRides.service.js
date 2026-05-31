import { GroupRidesRepository } from './groupRides.repository.js';

export class GroupRidesService {
  constructor(repository = new GroupRidesRepository()) {
    this.repository = repository;
  }

  create(userId, data) {
    return this.repository.create(userId, data);
  }

  join(userId, groupRideId) {
    return this.repository.join(userId, groupRideId);
  }

  recordLocation(userId, groupRideId, data) {
    return this.repository.recordLocation(userId, groupRideId, data);
  }

  liveLocations(groupRideId) {
    return this.repository.liveLocations(groupRideId);
  }
}

