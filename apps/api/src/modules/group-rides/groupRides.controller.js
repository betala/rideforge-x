import { asyncHandler } from '../../utils/asyncHandler.js';
import { GroupRidesService } from './groupRides.service.js';

const service = new GroupRidesService();

export const createGroupRide = asyncHandler(async (req, res) => {
  const data = await service.create(req.user.id, req.body);
  res.status(201).json({ data });
});

export const joinGroupRide = asyncHandler(async (req, res) => {
  await service.join(req.user.id, req.params.id);
  res.status(204).send();
});

export const recordRideLocation = asyncHandler(async (req, res) => {
  const data = await service.recordLocation(req.user.id, req.params.id, req.body);
  res.status(201).json({ data });
});

export const liveRideLocations = asyncHandler(async (req, res) => {
  const data = await service.liveLocations(req.params.id);
  res.json({ data });
});

