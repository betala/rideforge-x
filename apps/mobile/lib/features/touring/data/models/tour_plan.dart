class TourPlan {
  const TourPlan({
    required this.id,
    required this.name,
    required this.waypoints,
    this.motorcycleId,
    this.startDate,
    this.endDate,
    this.routeGeometry,
    this.distanceKm,
    this.etaMinutes,
  });

  final String id;
  final String name;
  final String? motorcycleId;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<Waypoint> waypoints;
  final String? routeGeometry;
  final num? distanceKm;
  final int? etaMinutes;

  factory TourPlan.fromJson(Map<String, dynamic> json) => TourPlan(
        id: json['id'] as String,
        name: json['name'] as String,
        motorcycleId: json['motorcycleId'] as String?,
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
        waypoints: ((json['waypoints'] as List?) ?? [])
            .map((item) => Waypoint.fromJson(Map<String, dynamic>.from(item as Map)))
            .toList(),
        routeGeometry: json['routeGeometry'] as String?,
        distanceKm: json['distanceKm'] as num?,
        etaMinutes: json['etaMinutes'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'motorcycleId': motorcycleId,
        'startDate': startDate?.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'waypoints': waypoints.map((item) => item.toJson()).toList(),
        'routeGeometry': routeGeometry,
        'distanceKm': distanceKm,
        'etaMinutes': etaMinutes,
      };
}

class Waypoint {
  const Waypoint({required this.label, required this.lat, required this.lng});

  final String label;
  final double lat;
  final double lng;

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        label: json['label'] as String,
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => {'label': label, 'lat': lat, 'lng': lng};
}

