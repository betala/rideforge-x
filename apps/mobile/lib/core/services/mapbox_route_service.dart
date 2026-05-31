import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/touring/data/models/tour_plan.dart';

final mapboxRouteServiceProvider = Provider<MapboxRouteService>((ref) {
  return MapboxRouteService();
});

class MapboxRouteService {
  MapboxRoutePreview preview(List<Waypoint> waypoints) {
    final legs = waypoints.length <= 1 ? 0 : waypoints.length - 1;
    return MapboxRoutePreview(
      waypointCount: waypoints.length,
      estimatedDistanceKm: legs * 85,
      estimatedMinutes: legs * 95,
    );
  }
}

class MapboxRoutePreview {
  const MapboxRoutePreview({
    required this.waypointCount,
    required this.estimatedDistanceKm,
    required this.estimatedMinutes,
  });

  final int waypointCount;
  final num estimatedDistanceKm;
  final int estimatedMinutes;
}

