import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/group_ride.dart';

final groupRideRepositoryProvider = Provider<GroupRideRepository>((ref) {
  return GroupRideRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.groupRidesBox),
  );
});

class GroupRideRepository {
  GroupRideRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<GroupRide> cached() {
    return _box.values.map((value) => GroupRide.fromJson(Map<String, dynamic>.from(value))).toList();
  }

  Future<GroupRide> create(GroupRide ride) async {
    await _box.put(ride.id, ride.toJson());
    final payload = await _apiClient.postJson(ApiPaths.groupRides, ride.toJson());
    final created = GroupRide.fromJson(Map<String, dynamic>.from(payload['data'] as Map));
    await _box.put(created.id, created.toJson());
    return created;
  }

  Future<void> join(String groupRideId, String inviteCode) async {
    await _apiClient.postJson('${ApiPaths.groupRides}/$groupRideId/join', {'inviteCode': inviteCode});
  }

  Future<void> recordLocation(String groupRideId, RideLocation location) async {
    await _apiClient.postJson('${ApiPaths.groupRides}/$groupRideId/locations', location.toJson());
  }
}

