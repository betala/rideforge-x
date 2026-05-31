import { asyncHandler } from '../../utils/asyncHandler.js';
import { GarageService } from './garage.service.js';

const service = new GarageService();

export const listMotorcycles = asyncHandler(async (req, res) => {
  const data = await service.list(req.user.id);
  res.json({ data });
});

export const createMotorcycle = asyncHandler(async (req, res) => {
  const data = await service.create(req.user.id, req.body);
  res.status(201).json({ data });
});

export const updateMotorcycle = asyncHandler(async (req, res) => {
  const data = await service.update(req.user.id, req.params.id, req.body);
  res.json({ data });
});

export const deleteMotorcycle = asyncHandler(async (req, res) => {
  await service.remove(req.user.id, req.params.id);
  res.status(204).send();
});

