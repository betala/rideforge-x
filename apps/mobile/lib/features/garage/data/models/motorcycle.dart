class Motorcycle {
  const Motorcycle({
    required this.id,
    required this.nickname,
    required this.make,
    required this.model,
    required this.year,
    required this.odometerKm,
    this.vin,
    this.purchaseDate,
    this.imageUrl,
  });

  final String id;
  final String nickname;
  final String make;
  final String model;
  final int year;
  final int odometerKm;
  final String? vin;
  final DateTime? purchaseDate;
  final String? imageUrl;

  factory Motorcycle.fromJson(Map<String, dynamic> json) => Motorcycle(
        id: json['id'] as String,
        nickname: json['nickname'] as String,
        make: json['make'] as String,
        model: json['model'] as String,
        year: json['year'] as int,
        odometerKm: json['odometerKm'] as int,
        vin: json['vin'] as String?,
        purchaseDate: json['purchaseDate'] == null ? null : DateTime.parse(json['purchaseDate'] as String),
        imageUrl: json['imageUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nickname': nickname,
        'make': make,
        'model': model,
        'year': year,
        'odometerKm': odometerKm,
        'vin': vin,
        'purchaseDate': purchaseDate?.toIso8601String(),
        'imageUrl': imageUrl,
      };
}

