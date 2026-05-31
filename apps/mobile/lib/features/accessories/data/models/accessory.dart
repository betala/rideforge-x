class Accessory {
  const Accessory({
    required this.id,
    required this.motorcycleId,
    required this.name,
    required this.category,
    this.brand,
    this.installedOn,
    this.cost,
    this.currency,
    this.warrantyUntil,
    this.notes,
  });

  final String id;
  final String motorcycleId;
  final String name;
  final String category;
  final String? brand;
  final DateTime? installedOn;
  final num? cost;
  final String? currency;
  final DateTime? warrantyUntil;
  final String? notes;

  factory Accessory.fromJson(Map<String, dynamic> json) => Accessory(
        id: json['id'] as String,
        motorcycleId: json['motorcycleId'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        brand: json['brand'] as String?,
        installedOn: json['installedOn'] == null ? null : DateTime.parse(json['installedOn'] as String),
        cost: json['cost'] as num?,
        currency: json['currency'] as String?,
        warrantyUntil: json['warrantyUntil'] == null ? null : DateTime.parse(json['warrantyUntil'] as String),
        notes: json['notes'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'motorcycleId': motorcycleId,
        'name': name,
        'category': category,
        'brand': brand,
        'installedOn': installedOn?.toIso8601String(),
        'cost': cost,
        'currency': currency,
        'warrantyUntil': warrantyUntil?.toIso8601String(),
        'notes': notes,
      };
}

