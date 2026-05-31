import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/tour_plan.dart';

final tourPlanRepositoryProvider = Provider<TourPlanRepository>((ref) {
  return TourPlanRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.tourPlansBox),
  );
});

class TourPlanRepository {
  TourPlanRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<TourPlan> cached() {
    return _box.values.map((value) => TourPlan.fromJson(Map<String, dynamic>.from(value))).toList();
  }

  Future<List<TourPlan>> sync() async {
    final payload = await _apiClient.getJson(ApiPaths.tourPlans);
    final plans = ((payload['data'] as List?) ?? [])
        .map((item) => TourPlan.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    for (final plan in plans) {
      await _box.put(plan.id, plan.toJson());
    }

    return plans;
  }

  Future<TourPlan> optimizeRoute(String tourPlanId, List<Waypoint> waypoints) async {
    final payload = await _apiClient.postJson(
      '${ApiPaths.tourPlans}/$tourPlanId/optimize-route',
      {'waypoints': waypoints.map((item) => item.toJson()).toList()},
    );
    final plan = TourPlan.fromJson(Map<String, dynamic>.from(payload['data'] as Map));
    await _box.put(plan.id, plan.toJson());
    return plan;
  }
}

