import { asyncHandler } from '../../utils/asyncHandler.js';
import { MaintenanceService } from './maintenance.service.js';

const service = new MaintenanceService();

export const listMaintenanceTasks = asyncHandler(async (req, res) => {
  const data = await service.list(req.user.id, req.params.motorcycleId);
  res.json({ data });
});

export const createMaintenanceTask = asyncHandler(async (req, res) => {
  const data = await service.create(req.user.id, req.params.motorcycleId, req.body);
  res.status(201).json({ data });
});

export const completeMaintenanceTask = asyncHandler(async (req, res) => {
  const data = await service.complete(req.user.id, req.params.id, req.body);
  res.json({ data });
});

