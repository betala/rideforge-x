import 'dotenv/config';

export const env = {
  nodeEnv: process.env.NODE_ENV ?? 'development',
  port: Number(process.env.PORT ?? 4000),
  databaseUrl: process.env.DATABASE_URL,
  firebaseStorageBucket: process.env.FIREBASE_STORAGE_BUCKET,
  mapboxAccessToken: process.env.MAPBOX_ACCESS_TOKEN,
  aiDiagnosticsEndpoint: process.env.AI_DIAGNOSTICS_ENDPOINT,
  aiDiagnosticsApiKey: process.env.AI_DIAGNOSTICS_API_KEY,
};

if (!env.databaseUrl) {
  throw new Error('DATABASE_URL is required');
}

