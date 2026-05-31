import cors from 'cors';
import express from 'express';
import helmet from 'helmet';

import { errorHandler } from './middleware/errorHandler.js';
import { injectUser } from './middleware/injectUser.js';
import { accessoriesRouter } from './modules/accessories/accessories.routes.js';
import { diagnosticsRouter } from './modules/diagnostics/diagnostics.routes.js';
import { garageRouter } from './modules/garage/garage.routes.js';
import { groupRidesRouter } from './modules/group-rides/groupRides.routes.js';
import { maintenanceRouter } from './modules/maintenance/maintenance.routes.js';
import { mediaRouter } from './modules/media/media.routes.js';
import { serviceHistoryRouter } from './modules/service-history/serviceHistory.routes.js';
import { touringRouter } from './modules/touring/touring.routes.js';

export function createApp() {
  const app = express();

  app.use(helmet());
  app.use(cors());
  app.use(express.json({ limit: '5mb' }));
  app.use(injectUser);

  app.get('/health', (_req, res) => res.json({ status: 'ok' }));

  const api = express.Router();
  api.use('/motorcycles', garageRouter);
  api.use('/motorcycles', serviceHistoryRouter);
  api.use('/motorcycles', maintenanceRouter);
  api.use('/motorcycles', accessoriesRouter);
  api.use('/tour-plans', touringRouter);
  api.use('/group-rides', groupRidesRouter);
  api.use('/diagnostics', diagnosticsRouter);
  api.use('/media', mediaRouter);

  app.use('/api/v1', api);
  app.use(errorHandler);

  return app;
}

