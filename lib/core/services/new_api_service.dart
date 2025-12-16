import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/constants/api_constants.dart';
import 'auth_interceptor.dart';

/// Minimal API Service that provides a configured Dio instance.
///
/// Features:
/// - Configured Dio with base URL from [ApiConstants]
/// - Automatic token injection via [AuthInterceptor]
/// - 401 Unauthorized callback
///
/// Usage in data source:
/// ```dart
/// class MyDataSource {
///   final NewApiService apiService;
///
///   Future<List<Entity>> getData() async {
///     final response = await apiService.dio.get('endpoint');
///     // Handle response and errors here
///   }
/// }
/// ```
class NewApiService {
  late final Dio dio;
  final FlutterSecureStorage _secureStorage;

  /// Static callback for 401 Unauthorized - set this in main.dart
  /// Example: `NewApiService.onUnauthorized = () => router.go('/login');`
  static void Function()? onUnauthorized;

  NewApiService(this._secureStorage) {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'text/plain',
      },
    ));

    // Add authentication interceptor (auto-injects token)
    dio.interceptors.add(AuthInterceptor(
      _secureStorage,
      onUnauthorized: () => onUnauthorized?.call(),
    ));
  }
}
