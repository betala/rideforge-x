import { env } from '../config/env.js';

export class MapboxService {
  async optimizeRoute({ waypoints }) {
    // Wire this to Mapbox Directions or Optimization API in production.
    return {
      routeGeometry: null,
      distanceKm: Math.max(0, waypoints.length - 1) * 85,
      etaMinutes: Math.max(0, waypoints.length - 1) * 95,
      provider: env.mapboxAccessToken ? 'mapbox' : 'stub',
    };
  }
}

