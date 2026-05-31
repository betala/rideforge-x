import { Router } from 'express';

import { analyzeDiagnostics } from './diagnostics.controller.js';

export const diagnosticsRouter = Router();

diagnosticsRouter.post('/analyze', analyzeDiagnostics);

