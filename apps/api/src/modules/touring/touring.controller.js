import { asyncHandler } from '../../utils/asyncHandler.js';
import { TouringService } from './touring.service.js';

const service = new TouringService();

export const listTourPlans = asyncHandler(async (req, res) => {
  const data = await service.list(req.user.id);
  res.json({ data });
});

export const createTourPlan = asyncHandler(async (req, res) => {
  const data = await service.create(req.user.id, req.body);
  res.status(201).json({ data });
});

export const optimizeTourRoute = asyncHandler(async (req, res) => {
  const data = await service.optimizeRoute(req.user.id, req.params.id, req.body);
  res.json({ data });
});

