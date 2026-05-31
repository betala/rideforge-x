import { Router } from 'express';

import { createTourPlan, listTourPlans, optimizeTourRoute } from './touring.controller.js';

export const touringRouter = Router();

touringRouter.get('/', listTourPlans);
touringRouter.post('/', createTourPlan);
touringRouter.post('/:id/optimize-route', optimizeTourRoute);

