import { asyncHandler } from '../../utils/asyncHandler.js';
import { DiagnosticsService } from './diagnostics.service.js';

const service = new DiagnosticsService();

export const analyzeDiagnostics = asyncHandler(async (req, res) => {
  const data = await service.analyze(req.user.id, req.body);
  res.status(201).json({ data });
});

