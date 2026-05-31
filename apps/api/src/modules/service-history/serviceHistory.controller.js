import { asyncHandler } from '../../utils/asyncHandler.js';
import { ServiceHistoryService } from './serviceHistory.service.js';

const service = new ServiceHistoryService();

export const listServiceRecords = asyncHandler(async (req, res) => {
  const data = await service.list(req.user.id, req.params.motorcycleId);
  res.json({ data });
});

export const createServiceRecord = asyncHandler(async (req, res) => {
  const data = await service.create(req.user.id, req.params.motorcycleId, req.body);
  res.status(201).json({ data });
});

