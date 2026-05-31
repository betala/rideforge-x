import { Router } from 'express';

import {
  createGroupRide,
  joinGroupRide,
  liveRideLocations,
  recordRideLocation,
} from './groupRides.controller.js';

export const groupRidesRouter = Router();

groupRidesRouter.post('/', createGroupRide);
groupRidesRouter.post('/:id/join', joinGroupRide);
groupRidesRouter.post('/:id/locations', recordRideLocation);
groupRidesRouter.get('/:id/locations/live', liveRideLocations);

