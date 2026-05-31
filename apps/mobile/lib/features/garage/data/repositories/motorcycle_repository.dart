import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/motorcycle.dart';

final motorcycleRepositoryProvider = Provider<MotorcycleRepository>((ref) {
  return MotorcycleRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.motorcyclesBox),
  );
});

class MotorcycleRepository {
  MotorcycleRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<Motorcycle> cached() {
    return _box.values
        .map((value) => Motorcycle.fromJson(Map<String, dynamic>.from(value)))
        .toList();
  }

  Future<List<Motorcycle>> sync() async {
    final payload = await _apiClient.getJson(ApiPaths.motorcycles);
    final motorcycles = ((payload['data'] as List?) ?? [])
        .map((item) => Motorcycle.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    for (final motorcycle in motorcycles) {
      await _box.put(motorcycle.id, motorcycle.toJson());
    }

    return motorcycles;
  }

  Future<Motorcycle> create(Motorcycle motorcycle) async {
    await _box.put(motorcycle.id, motorcycle.toJson());
    final payload = await _apiClient.postJson(ApiPaths.motorcycles, motorcycle.toJson());
    final created = Motorcycle.fromJson(Map<String, dynamic>.from(payload['data'] as Map));
    await _box.put(created.id, created.toJson());
    return created;
  }
}
