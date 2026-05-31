class GroupRide {
  const GroupRide({
    required this.id,
    required this.name,
    required this.visibility,
    required this.startsAt,
    this.tourPlanId,
    this.inviteCode,
  });

  final String id;
  final String name;
  final String visibility;
  final DateTime startsAt;
  final String? tourPlanId;
  final String? inviteCode;

  factory GroupRide.fromJson(Map<String, dynamic> json) => GroupRide(
        id: json['id'] as String,
        name: json['name'] as String,
        visibility: json['visibility'] as String,
        startsAt: DateTime.parse(json['startsAt'] as String),
        tourPlanId: json['tourPlanId'] as String?,
        inviteCode: json['inviteCode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'visibility': visibility,
        'startsAt': startsAt.toIso8601String(),
        'tourPlanId': tourPlanId,
        'inviteCode': inviteCode,
      };
}

class RideLocation {
  const RideLocation({
    required this.memberId,
    required this.lat,
    required this.lng,
    required this.recordedAt,
    this.speedKph,
    this.heading,
  });

  final String memberId;
  final double lat;
  final double lng;
  final DateTime recordedAt;
  final num? speedKph;
  final num? heading;

  factory RideLocation.fromJson(Map<String, dynamic> json) => RideLocation(
        memberId: json['memberId'] as String,
        lat: (json['lat'] as num).toDouble(),
        lng: (json['lng'] as num).toDouble(),
        recordedAt: DateTime.parse(json['recordedAt'] as String),
        speedKph: json['speedKph'] as num?,
        heading: json['heading'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'lat': lat,
        'lng': lng,
        'recordedAt': recordedAt.toIso8601String(),
        'speedKph': speedKph,
        'heading': heading,
      };
}

