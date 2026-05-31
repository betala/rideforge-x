import { asyncHandler } from '../../utils/asyncHandler.js';
import { MediaService } from './media.service.js';

const service = new MediaService();

export const createUploadIntent = asyncHandler(async (req, res) => {
  const data = await service.createUploadIntent(req.user.id, req.body);
  res.status(201).json({ data });
});

export const listMedia = asyncHandler(async (req, res) => {
  const data = await service.list(req.user.id, req.query.ownerType, req.query.ownerId);
  res.json({ data });
});

