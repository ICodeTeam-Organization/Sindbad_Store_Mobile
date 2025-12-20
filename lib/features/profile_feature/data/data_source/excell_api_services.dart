import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/constants/api_constants.dart';
import 'package:sindbad_management_app/core/services/auth_interceptor.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';

/// BulkService handles bulk file operations (download/upload Excel files).
///
/// Configures its own Dio instance with [AuthInterceptor] for automatic
/// token injection - no manual token handling needed in methods.
class BulkService {
  final FlutterSecureStorage _secureStorage;
  late final Dio dio;

  /// Static callback for 401 Unauthorized - reuses NewApiService callback
  static void Function()? onUnauthorized;

  BulkService(this._secureStorage) {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.baseUrlBulk,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    // Add authentication interceptor (auto-injects token)
    dio.interceptors.add(AuthInterceptor(
      _secureStorage,
      onUnauthorized: () => onUnauthorized?.call(),
    ));
  }
  Future<List<FileModel>> getFilesNames() async {
    try {
      final body = json.encode("GET_TO_DOWN_FILES");

      final response = await dio.post(
        'GetUserToDownFilesList',
        data: body,
      );

      if (response.statusCode == 200) {
        print("DEBUG: Response Type: ${response.data.runtimeType}");
        print("DEBUG: Response Data: ${response.data}");

        List<dynamic> listData;
        if (response.data is List) {
          listData = response.data;
        } else if (response.data is Map<String, dynamic>) {
          // Attempt to find the list if it's wrapped
          // Common keys: 'data', 'result', 'value', 'items'
          final mapData = response.data as Map<String, dynamic>;
          if (mapData.containsKey('data') && mapData['data'] is List) {
            listData = mapData['data'];
          } else if (mapData.containsKey('result') &&
              mapData['result'] is List) {
            listData = mapData['result'];
          } else if (mapData.containsKey('value') && mapData['value'] is List) {
            listData = mapData['value'];
          } else {
            throw Exception(
                "Response is a Map but couldn't find a List inside. Keys: ${mapData.keys}");
          }
        } else {
          throw Exception(
              "Unexpected response type: ${response.data.runtimeType}");
        }

        final List<FileModel> files =
            listData.map((json) => FileModel.fromJson(json)).toList();
        return files; // SUCCESS
      } else {
        throw Exception(
          "Request failed | Status Code: ${response.statusCode} | Message: ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      // Dio-specific error (timeouts, no internet...)
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      // Any other error
      throw Exception("Unexpected error: $e");
    }
  }
  // Future<List<FileModel>> getFilesNames() async {
  //   try {
  //     final token = await _secureStorage.read(key: 'token');
  //     if (token == null) {
  //       throw Exception('Token not found');
  //     }
  //     const body = 'GET_TO_DOWN_FILES';
  //     final response = await dio.post(
  //       '${ApiConstants.baseUrlBulk}GetUserToDownFilesList',
  //       data: body,
  //       options: Options(
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': 'Bearer $token',
  //         },
  //         // Send as raw string, prevent Dio from re-encoding
  //         contentType: 'application/json',
  //       ),
  //     );
  //     // JSON.stringify("GET_TO_DOWN_FILES") in JS = json.encode in Dart
  //     // This produces: "GET_TO_DOWN_FILES" (with quotes - important!)

  //     // final response = await dio.post(
  //     //   'GetUserToDownFilesList',
  //     //   data: body,
  //     //   options: Options(
  //     //     // Send as raw string, prevent Dio from re-encoding
  //     //     contentType: 'application/json',
  //     //   ),
  //     // );

  //     if (response.statusCode == 200) {
  //       print("DEBUG: Response Type: ${response.data.runtimeType}");
  //       print("DEBUG: Response Data: ${response.data}");

  //       List<dynamic> listData;
  //       if (response.data is List) {
  //         listData = response.data;
  //       } else if (response.data is Map<String, dynamic>) {
  //         final mapData = response.data as Map<String, dynamic>;
  //         if (mapData.containsKey('data') && mapData['data'] is List) {
  //           listData = mapData['data'];
  //         } else if (mapData.containsKey('result') &&
  //             mapData['result'] is List) {
  //           listData = mapData['result'];
  //         } else if (mapData.containsKey('value') && mapData['value'] is List) {
  //           listData = mapData['value'];
  //         } else {
  //           throw Exception(
  //               "Response is a Map but couldn't find a List inside. Keys: ${mapData.keys}");
  //         }
  //       } else {
  //         throw Exception(
  //             "Unexpected response type: ${response.data.runtimeType}");
  //       }

  //       final List<FileModel> files =
  //           listData.map((json) => FileModel.fromJson(json)).toList();
  //       return files;
  //     } else {
  //       throw Exception(
  //         "Request failed | Status Code: ${response.statusCode} | Message: ${response.statusMessage}",
  //       );
  //     }
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.connectionTimeout) {
  //       throw Exception(
  //           "Connection timeout - server unreachable at ${ApiConstants.baseUrlBulk}");
  //     } else if (e.type == DioExceptionType.receiveTimeout) {
  //       throw Exception("Receive timeout - server took too long to respond");
  //     } else if (e.type == DioExceptionType.sendTimeout) {
  //       throw Exception("Send timeout - request took too long to send");
  //     }
  //     throw Exception("Dio error: ${e.message}");
  //   } catch (e) {
  //     throw Exception("Unexpected error: $e");
  //   }
  // }

  /// Download a single file from the server and return raw bytes
  Future<List<int>> downloadFile(String fileName) async {
    try {
      final body = json.encode("GET_TO_DOWN_FILES");

      final response = await Dio().post(
        'BulkDownload/$fileName',
        data: body,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>).cast<int>();
      } else {
        throw Exception(
          "Request failed | Status Code: ${response.statusCode} | Message: ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<int>> downloadSpecificFile(String fileName) async {
    try {
      final body = json.encode("GET_TO_DOWN_FILES");

      final response = await Dio().post(
        'BulkDownload/$fileName',
        data: body,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );

      if (response.statusCode == 200) {
        return (response.data as List<dynamic>).cast<int>();
      } else {
        throw Exception(
          "Request failed | Status Code: ${response.statusCode} | Message: ${response.statusMessage}",
        );
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Response> sendBulkAction({
    required int actionInt,
    required Map<String, String> fields,
    Map<String, String>? files,
  }) async {
    late String endpoint;

    if (actionInt == 1) {
      endpoint = 'api/Products/Bulk_AddPrdctsWthAllDtls';
    } else if (actionInt > 1 && actionInt < 9) {
      endpoint = 'api/Products/BulkProductsActions';
      fields['curAction'] = actionInt.toString();
    } else if (actionInt > 30 && actionInt < 50) {
      endpoint = 'api/BulkRecordStoreCats';
      fields['curAction'] = actionInt.toString();
    } else {
      throw Exception("Invalid actionInt: $actionInt");
    }

    // Build FormData for multipart request
    final formData = FormData.fromMap({
      ...fields,
      if (files != null)
        for (var entry in files.entries)
          entry.key: await MultipartFile.fromFile(entry.value),
    });

    try {
      final response = await dio.post(
        endpoint,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  /// Upload an Excel file with a specific action.
  ///
  /// [filePath] - Local path to the Excel file to upload
  /// [action] - Action string that determines the endpoint:
  ///   - 1: Bulk_AddPrdctsWthAllDtls
  ///   - 2-8: BulkProductsActions
  ///   - 31-49: BulkRecordStoreCats
  ///   - 101-109: GetImagesFromNetByText
  /// [storeId] - Optional store ID
  /// [isOfficial] - Optional official flag
  Future<Response> uploadExcelFile({
    required String filePath,
    required String action,
    String? storeId,
    bool? isOfficial,
  }) async {
    final actionInt = int.parse(action);
    late String endpoint;

    // Determine endpoint based on action
    if (actionInt == 1) {
      endpoint = 'api/Products/Bulk_AddPrdctsWthAllDtls';
    } else if (actionInt > 1 && actionInt < 9) {
      endpoint = 'api/Products/BulkProductsActions';
    } else if (actionInt > 30 && actionInt < 50) {
      endpoint = 'api/BulkRecordStoreCats';
    } else if (actionInt > 100 && actionInt < 110) {
      endpoint = 'GetImagesFromNetByText';
    } else {
      throw Exception("Invalid action: $action");
    }

    // Build FormData
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      if (storeId != null) 'pStoreId': storeId,
      if (isOfficial != null) 'isOfficial': isOfficial.toString(),
      if (actionInt != 1) 'curAction': action,
    });

    try {
      final response = await dio.post(
        endpoint,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection timeout - server unreachable");
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Receive timeout - server took too long to respond");
      } else if (e.type == DioExceptionType.sendTimeout) {
        throw Exception("Send timeout - file upload took too long");
      }
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }
}
