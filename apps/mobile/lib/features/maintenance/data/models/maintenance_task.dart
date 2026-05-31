class MaintenanceTask {
  const MaintenanceTask({
    required this.id,
    required this.motorcycleId,
    required this.title,
    required this.category,
    required this.priority,
    required this.status,
    this.dueDate,
    this.dueOdometerKm,
    this.completedAt,
    this.completedOdometerKm,
    this.notes,
  });

  final String id;
  final String motorcycleId;
  final String title;
  final String category;
  final String priority;
  final String status;
  final DateTime? dueDate;
  final int? dueOdometerKm;
  final DateTime? completedAt;
  final int? completedOdometerKm;
  final String? notes;

  factory MaintenanceTask.fromJson(Map<String, dynamic> json) => MaintenanceTask(
        id: json['id'] as String,
        motorcycleId: json['motorcycleId'] as String,
        title: json['title'] as String,
        category: json['category'] as String,
        priority: json['priority'] as String,
        status: json['status'] as String,
        dueDate: json['dueDate'] == null ? null : DateTime.parse(json['dueDate'] as String),
        dueOdometerKm: json['dueOdometerKm'] as int?,
        completedAt: json['completedAt'] == null ? null : DateTime.parse(json['completedAt'] as String),
        completedOdometerKm: json['completedOdometerKm'] as int?,
        notes: json['notes'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'motorcycleId': motorcycleId,
        'title': title,
        'category': category,
        'priority': priority,
        'status': status,
        'dueDate': dueDate?.toIso8601String(),
        'dueOdometerKm': dueOdometerKm,
        'completedAt': completedAt?.toIso8601String(),
        'completedOdometerKm': completedOdometerKm,
        'notes': notes,
      };
}
