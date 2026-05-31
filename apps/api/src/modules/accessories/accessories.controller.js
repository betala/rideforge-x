import { asyncHandler } from '../../utils/asyncHandler.js';
import { AccessoriesService } from './accessories.service.js';

const service = new AccessoriesService();

export const listAccessories = asyncHandler(async (req, res) => {
  const data = await service.list(req.user.id, req.params.motorcycleId);
  res.json({ data });
});

export const createAccessory = asyncHandler(async (req, res) => {
  const data = await service.create(req.user.id, req.params.motorcycleId, req.body);
  res.status(201).json({ data });
});

