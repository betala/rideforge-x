import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/accessory.dart';

final accessoryRepositoryProvider = Provider<AccessoryRepository>((ref) {
  return AccessoryRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.accessoriesBox),
  );
});

class AccessoryRepository {
  AccessoryRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<Accessory> cached(String motorcycleId) {
    return _box.values
        .map((value) => Accessory.fromJson(Map<String, dynamic>.from(value)))
        .where((item) => item.motorcycleId == motorcycleId)
        .toList();
  }

  Future<List<Accessory>> sync(String motorcycleId) async {
    final payload = await _apiClient.getJson('/motorcycles/$motorcycleId/accessories');
    final accessories = ((payload['data'] as List?) ?? [])
        .map((item) => Accessory.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    for (final accessory in accessories) {
      await _box.put(accessory.id, accessory.toJson());
    }

    return accessories;
  }
}

