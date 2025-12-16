import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Dio Interceptor that handles authentication automatically.
///
/// - Adds Authorization header to all requests if token exists
/// - Handles 401 Unauthorized responses by clearing token and calling onUnauthorized
class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;
  final void Function()? onUnauthorized;

  AuthInterceptor(this._secureStorage, {this.onUnauthorized});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Get token from secure storage
    final token = await _secureStorage.read(key: 'token');

    // Add Authorization header if token exists
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'BEARER $token';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      // Clear the invalid token
      await _secureStorage.delete(key: 'token');

      // Notify listener (e.g., navigate to login)
      onUnauthorized?.call();
    }

    handler.next(err);
  }
}
