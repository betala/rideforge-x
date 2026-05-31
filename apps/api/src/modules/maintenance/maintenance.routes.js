import { Router } from 'express';

import {
  completeMaintenanceTask,
  createMaintenanceTask,
  listMaintenanceTasks,
} from './maintenance.controller.js';

export const maintenanceRouter = Router();

maintenanceRouter.get('/:motorcycleId/maintenance-tasks', listMaintenanceTasks);
maintenanceRouter.post('/:motorcycleId/maintenance-tasks', createMaintenanceTask);
maintenanceRouter.patch('/:motorcycleId/maintenance-tasks/:id/complete', completeMaintenanceTask);
