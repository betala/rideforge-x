import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../../core/constants/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/storage/offline_store.dart';
import '../models/media_item.dart';

final mediaRepositoryProvider = Provider<MediaRepository>((ref) {
  return MediaRepository(
    apiClient: ref.watch(apiClientProvider),
    box: Hive.box<Map>(OfflineStore.mediaBox),
  );
});

class MediaRepository {
  MediaRepository({required ApiClient apiClient, required Box<Map> box})
      : _apiClient = apiClient,
        _box = box;

  final ApiClient _apiClient;
  final Box<Map> _box;

  List<MediaItem> cached({required String ownerType, required String ownerId}) {
    return _box.values
        .map((value) => MediaItem.fromJson(Map<String, dynamic>.from(value)))
        .where((item) => item.ownerType == ownerType && item.ownerId == ownerId)
        .toList();
  }

  Future<Map<String, dynamic>> createUploadIntent({
    required String ownerType,
    required String ownerId,
    required String fileName,
    required String contentType,
  }) async {
    final payload = await _apiClient.postJson('${ApiPaths.media}/upload-intent', {
      'ownerType': ownerType,
      'ownerId': ownerId,
      'fileName': fileName,
      'contentType': contentType,
    });
    final data = Map<String, dynamic>.from(payload['data'] as Map);
    final mediaItem = MediaItem.fromJson(data);
    await _box.put(mediaItem.id, mediaItem.toJson());
    return data;
  }

  Future<List<MediaItem>> sync({required String ownerType, required String ownerId}) async {
    final payload = await _apiClient.getJson('${ApiPaths.media}?ownerType=$ownerType&ownerId=$ownerId');
    final items = ((payload['data'] as List?) ?? [])
        .map((item) => MediaItem.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    for (final item in items) {
      await _box.put(item.id, item.toJson());
    }

    return items;
  }
}
