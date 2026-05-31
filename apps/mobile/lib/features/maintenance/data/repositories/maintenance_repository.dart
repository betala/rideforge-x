import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/maintenance_task.dart';

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.maintenanceTasksBox),
  );
});

class MaintenanceRepository {
  MaintenanceRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<MaintenanceTask> cached(String motorcycleId) {
    return _box.values
        .map((value) => MaintenanceTask.fromJson(Map<String, dynamic>.from(value)))
        .where((item) => item.motorcycleId == motorcycleId)
        .toList();
  }

  Future<List<MaintenanceTask>> sync(String motorcycleId) async {
    final payload = await _apiClient.getJson('/motorcycles/$motorcycleId/maintenance-tasks');
    final tasks = ((payload['data'] as List?) ?? [])
        .map((item) => MaintenanceTask.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    for (final task in tasks) {
      await _box.put(task.id, task.toJson());
    }

    return tasks;
  }

  Future<MaintenanceTask> complete(String motorcycleId, String taskId, Map<String, dynamic> completion) async {
    final payload = await _apiClient.patchJson(
      '/motorcycles/$motorcycleId/maintenance-tasks/$taskId/complete',
      completion,
    );
    final task = MaintenanceTask.fromJson(Map<String, dynamic>.from(payload['data'] as Map));
    await _box.put(task.id, task.toJson());
    return task;
  }
}

