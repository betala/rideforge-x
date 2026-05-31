# RideForge X Mobile

Flutter app scaffold using Riverpod, GoRouter, Hive, and Mapbox.

## Structure

```text
lib/
  main.dart
  app/
    app.dart
    router.dart
  core/
    constants/
    network/
    storage/
    theme/
  features/
    garage/
    service_history/
    maintenance/
    accessories/
    touring/
    group_rides/
    diagnostics/
    media/
```

## Environment

Pass runtime configuration with `--dart-define`:

```powershell
flutter run --dart-define=RIDEFORGE_API_BASE_URL=http://localhost:4000/api/v1 --dart-define=MAPBOX_ACCESS_TOKEN=your-token
```

