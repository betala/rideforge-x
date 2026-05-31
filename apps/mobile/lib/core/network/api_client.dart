import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants/api_paths.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

class ApiClient {
  ApiClient({http.Client? client, this.authToken}) : _client = client ?? http.Client();

  final http.Client _client;
  final String? authToken;

  Future<Map<String, dynamic>> getJson(String path) async {
    final response = await _client.get(_uri(path), headers: _headers);
    return _decode(response);
  }

  Future<Map<String, dynamic>> postJson(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      _uri(path),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> patchJson(String path, Map<String, dynamic> body) async {
    final response = await _client.patch(
      _uri(path),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Uri _uri(String path) => Uri.parse('${ApiPaths.baseUrl}$path');

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (authToken != null) 'Authorization': 'Bearer $authToken',
      };

  Map<String, dynamic> _decode(http.Response response) {
    final decoded = response.body.isEmpty ? <String, dynamic>{} : jsonDecode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded as Map<String, dynamic>;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: decoded is Map<String, dynamic>
          ? decoded['error']?['message']?.toString() ?? 'Request failed'
          : 'Request failed',
    );
  }
}

class ApiException implements Exception {
  ApiException({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}
