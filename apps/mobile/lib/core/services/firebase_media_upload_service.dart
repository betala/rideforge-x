import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseMediaUploadServiceProvider = Provider<FirebaseMediaUploadService>((ref) {
  return FirebaseMediaUploadService(FirebaseStorage.instance);
});

class FirebaseMediaUploadService {
  FirebaseMediaUploadService(this._storage);

  final FirebaseStorage _storage;

  Future<String> uploadBytes({
    required String storagePath,
    required Uint8List bytes,
    required String contentType,
  }) async {
    final ref = _storage.ref(storagePath);
    final snapshot = await ref.putData(bytes, SettableMetadata(contentType: contentType));
    return snapshot.ref.getDownloadURL();
  }
}

