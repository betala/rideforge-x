import { Router } from 'express';

import { createAccessory, listAccessories } from './accessories.controller.js';

export const accessoriesRouter = Router();

accessoriesRouter.get('/:motorcycleId/accessories', listAccessories);
accessoriesRouter.post('/:motorcycleId/accessories', createAccessory);

