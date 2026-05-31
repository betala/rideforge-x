import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/service_record.dart';

final serviceRecordRepositoryProvider = Provider<ServiceRecordRepository>((ref) {
  return ServiceRecordRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.serviceRecordsBox),
  );
});

class ServiceRecordRepository {
  ServiceRecordRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<ServiceRecord> cached(String motorcycleId) {
    return _box.values
        .map((value) => ServiceRecord.fromJson(Map<String, dynamic>.from(value)))
        .where((item) => item.motorcycleId == motorcycleId)
        .toList();
  }

  Future<List<ServiceRecord>> sync(String motorcycleId) async {
    final payload = await _apiClient.getJson('/motorcycles/$motorcycleId/service-records');
    final records = ((payload['data'] as List?) ?? [])
        .map((item) => ServiceRecord.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    for (final record in records) {
      await _box.put(record.id, record.toJson());
    }

    return records;
  }

  Future<ServiceRecord> create(String motorcycleId, ServiceRecord record) async {
    await _box.put(record.id, record.toJson());
    final payload = await _apiClient.postJson('/motorcycles/$motorcycleId/service-records', record.toJson());
    final created = ServiceRecord.fromJson(Map<String, dynamic>.from(payload['data'] as Map));
    await _box.put(created.id, created.toJson());
    return created;
  }
}

