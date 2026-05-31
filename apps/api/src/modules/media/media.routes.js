import { Router } from 'express';

import { createUploadIntent, listMedia } from './media.controller.js';

export const mediaRouter = Router();

mediaRouter.post('/upload-intent', createUploadIntent);
mediaRouter.get('/', listMedia);

