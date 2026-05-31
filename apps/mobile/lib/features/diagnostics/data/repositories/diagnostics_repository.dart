import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/diagnostic_report.dart';

final diagnosticsRepositoryProvider = Provider<DiagnosticsRepository>((ref) {
  return DiagnosticsRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.diagnosticsBox),
  );
});

class DiagnosticsRepository {
  DiagnosticsRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<DiagnosticReport> cached(String motorcycleId) {
    return _box.values
        .map((value) => DiagnosticReport.fromJson(Map<String, dynamic>.from(value)))
        .where((item) => item.motorcycleId == motorcycleId)
        .toList();
  }

  Future<DiagnosticReport> analyze({
    required String motorcycleId,
    required List<String> symptoms,
    List<String> obdCodes = const [],
    String? audioMediaId,
  }) async {
    final payload = await _apiClient.postJson('${ApiPaths.diagnostics}/analyze', {
      'motorcycleId': motorcycleId,
      'symptoms': symptoms,
      'obdCodes': obdCodes,
      'audioMediaId': audioMediaId,
    });
    final report = DiagnosticReport.fromJson(Map<String, dynamic>.from(payload['data'] as Map));
    await _box.put(report.id, report.toJson());
    return report;
  }
}

