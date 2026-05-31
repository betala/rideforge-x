import { Router } from 'express';

import { createServiceRecord, listServiceRecords } from './serviceHistory.controller.js';

export const serviceHistoryRouter = Router();

serviceHistoryRouter.get('/:motorcycleId/service-records', listServiceRecords);
serviceHistoryRouter.post('/:motorcycleId/service-records', createServiceRecord);

