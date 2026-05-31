class ServiceRecord {
  const ServiceRecord({
    required this.id,
    required this.motorcycleId,
    required this.serviceDate,
    required this.odometerKm,
    required this.summary,
    this.provider,
    this.cost,
    this.currency,
    this.invoiceMediaId,
  });

  final String id;
  final String motorcycleId;
  final DateTime serviceDate;
  final int odometerKm;
  final String summary;
  final String? provider;
  final num? cost;
  final String? currency;
  final String? invoiceMediaId;

  factory ServiceRecord.fromJson(Map<String, dynamic> json) => ServiceRecord(
        id: json['id'] as String,
        motorcycleId: json['motorcycleId'] as String,
        serviceDate: DateTime.parse(json['serviceDate'] as String),
        odometerKm: json['odometerKm'] as int,
        summary: json['summary'] as String,
        provider: json['provider'] as String?,
        cost: json['cost'] as num?,
        currency: json['currency'] as String?,
        invoiceMediaId: json['invoiceMediaId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'motorcycleId': motorcycleId,
        'serviceDate': serviceDate.toIso8601String(),
        'odometerKm': odometerKm,
        'summary': summary,
        'provider': provider,
        'cost': cost,
        'currency': currency,
        'invoiceMediaId': invoiceMediaId,
      };
}

