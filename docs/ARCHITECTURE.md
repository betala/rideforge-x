# RideForge X Architecture

## Product Shape

RideForge X is a motorcycle operating system for riders who manage premium bikes, long tours, service history, accessories, live rides, diagnostics, and media in one place.

## System Components

```text
Flutter Mobile App
  Riverpod state graph
  GoRouter navigation
  Hive offline cache
  Mapbox maps and routing
  Firebase Storage uploads
        |
        | HTTPS JSON API
        v
Node.js Express API
  Auth middleware
  Feature modules
  Repository layer
  Domain services
        |
        +--> PostgreSQL
        +--> Firebase Storage
        +--> Mapbox APIs
        +--> AI diagnostics provider
```

## Mobile Architecture

The Flutter app follows a feature-first clean architecture:

```text
lib/
  app/                 App shell, routes, root providers
  core/                Network, storage, constants, theme
  features/
    garage/
      data/
        models/
        repositories/
      domain/
      presentation/
```

Layer responsibilities:

- `presentation`: screens, widgets, controllers, Riverpod notifiers.
- `domain`: feature interfaces and app-level use cases.
- `data/models`: API and offline serializable models.
- `data/repositories`: sync remote API data into Hive and expose cached reads.
- `core/network`: HTTP client and API result handling.
- `core/storage`: Hive boxes and cache keys.

Offline-first behavior:

1. Read from Hive immediately.
2. Fetch remote data when online.
3. Merge server data into Hive.
4. Queue local mutations when offline.
5. Replay queued mutations after connectivity returns.

## Backend Architecture

The API is organized by bounded feature modules:

```text
src/
  app.js
  server.js
  config/
  db/
  middleware/
  modules/
    garage/
    service-history/
    maintenance/
    accessories/
    touring/
    group-rides/
    diagnostics/
    media/
  services/
```

Each module owns:

- `*.routes.js`: endpoint registration.
- `*.controller.js`: HTTP request/response shaping.
- `*.service.js`: business rules and integration orchestration.
- `*.repository.js`: SQL persistence.
- `*.model.js`: allowed fields and table metadata.

## Data Ownership

| Feature | Primary Table | Important Relations |
| --- | --- | --- |
| Motorcycle Garage | `motorcycles` | User owns many motorcycles |
| Service History | `service_records` | Belongs to motorcycle |
| Maintenance Tracking | `maintenance_tasks` | Belongs to motorcycle |
| Accessory Management | `accessories` | Belongs to motorcycle |
| Touring Planner | `tour_plans` | Belongs to user, optional motorcycle |
| Group Ride Tracking | `group_rides` | Ride has many members and location points |
| AI Diagnostics | `diagnostic_reports` | Belongs to motorcycle |
| Media Gallery | `media_items` | Belongs to motorcycle, tour, or ride |

## Integration Boundaries

- Firebase Storage stores photos, videos, invoices, and ride media. API returns signed upload and download metadata.
- Mapbox handles geocoding, route geometry, ETA, and route optimization.
- AI diagnostics service accepts symptoms, OBD codes, maintenance context, and service history, then returns severity, likely causes, and recommended actions.

## Security

- All feature routes require authenticated `userId`.
- Backend repositories scope every read and write by `user_id`.
- Media upload keys include user and entity scope.
- Location endpoints should use short retention windows for live group ride pings.

