class DiagnosticReport {
  const DiagnosticReport({
    required this.id,
    required this.motorcycleId,
    required this.severity,
    required this.confidence,
    required this.likelyCauses,
    required this.recommendedActions,
    required this.safeToRide,
    required this.createdAt,
  });

  final String id;
  final String motorcycleId;
  final String severity;
  final double confidence;
  final List<String> likelyCauses;
  final List<String> recommendedActions;
  final bool safeToRide;
  final DateTime createdAt;

  factory DiagnosticReport.fromJson(Map<String, dynamic> json) => DiagnosticReport(
        id: json['id'] as String,
        motorcycleId: json['motorcycleId'] as String,
        severity: json['severity'] as String,
        confidence: (json['confidence'] as num).toDouble(),
        likelyCauses: List<String>.from((json['likelyCauses'] as List?) ?? []),
        recommendedActions: List<String>.from((json['recommendedActions'] as List?) ?? []),
        safeToRide: json['safeToRide'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'motorcycleId': motorcycleId,
        'severity': severity,
        'confidence': confidence,
        'likelyCauses': likelyCauses,
        'recommendedActions': recommendedActions,
        'safeToRide': safeToRide,
        'createdAt': createdAt.toIso8601String(),
      };
}

