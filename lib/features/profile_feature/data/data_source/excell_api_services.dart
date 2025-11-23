import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';

class BulkService {
  final String baseUrl;
  final FlutterSecureStorage secureStorage;
  // final Dio dio;
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  BulkService(this.baseUrl, this.secureStorage);
  Future<List<FileModel>> getFilesNames() async {
    String? token = await getToken();
    try {
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = json.encode("GET_TO_DOWN_FILES");

      final response = await Dio().post(
        'https://sindibad-back.com:84/api/GetUserToDownFilesList',
        data: body,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final List<FileModel> files =
            response.data.map((json) => FileModel.fromJson(json)).toList();
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

  /// Download a single file from the server and return raw bytes
  Future<List<int>> downloadFile(String fileName) async {
    String? token = await getToken();

    try {
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final body = json.encode("GET_TO_DOWN_FILES");

      final response = await Dio().post(
        'https://sindibad-back.com:84/BulkDownload/$fileName',
        data: body,
        options: Options(
          headers: headers,
          responseType: ResponseType.bytes, // Important! Get raw bytes
        ),
      );

      if (response.statusCode == 200) {
        return response.data; // raw bytes
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

  Future<http.Response> sendBulkAction({
    required int actionInt,
    required Map<String, String> fields,
    Map<String, String>? files,
  }) async {
    late String url;

    if (actionInt == 1) {
      url = '$baseUrl/api/Products/Bulk_AddPrdctsWthAllDtls';
    } else if (actionInt > 1 && actionInt < 9) {
      url = '$baseUrl/api/Products/BulkProductsActions';
      fields['curAction'] = actionInt.toString();
    } else if (actionInt > 30 && actionInt < 50) {
      url = '$baseUrl/api/BulkRecordStoreCats';
      fields['curAction'] = actionInt.toString();
    } else {
      throw Exception("Invalid actionInt: $actionInt");
    }

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add normal fields
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // Add files (optional)
    if (files != null) {
      for (var entry in files.entries) {
        request.files
            .add(await http.MultipartFile.fromPath(entry.key, entry.value));
      }
    }

    // Send Request
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
