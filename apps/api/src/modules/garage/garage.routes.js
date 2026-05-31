import { Router } from 'express';

import {
  createMotorcycle,
  deleteMotorcycle,
  listMotorcycles,
  updateMotorcycle,
} from './garage.controller.js';

export const garageRouter = Router();

garageRouter.get('/', listMotorcycles);
garageRouter.post('/', createMotorcycle);
garageRouter.patch('/:id', updateMotorcycle);
garageRouter.delete('/:id', deleteMotorcycle);

