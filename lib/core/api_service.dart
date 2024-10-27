import 'dart:io';

import 'package:dio/dio.dart';

import 'errors/failure.dart';

class ApiService {
  final Dio _dio;
  final baseUrl = "https://icode-sendbad-store.runasp.net/api/";

  ApiService(this._dio);
  // {
  //   _dio.options.headers['Content-Type'] = 'application/json';
  // }

  Future<Map<String, dynamic>> get(
      {required String endPoint, Map<String, String>? headers}) async {
    var response =
        await _dio.get('$baseUrl$endPoint', options: Options(headers: headers));
    print(response.data);

    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endPoint,
      required dynamic data,
      Map<String, String>? headers}) async {
    try {
      var response = await _dio.post('$baseUrl$endPoint',
          data: data,
          options: Options(validateStatus: (_) => true, headers: headers));
      print(response.data);
      return response.data;
    } catch (e, s) {
      print('from api Exception details:\n $e');
      print('from api Stack trace:\n $s');
      if (e is DioException &&
          (e.type == DioExceptionType.unknown ||
              e.type == DioExceptionType.connectionTimeout ||
              e.type == DioExceptionType.connectionError)) {
        throw ServerFailure('No Internet Connection');
      } else if (e is SocketException) {
        // throw ServerFailure('No Internet Connection');
        if (e.message.contains('Failed host lookup')) {
          throw ServerFailure('Failed to resolve hostname');
        } else {
          throw ServerFailure('No Internet Connection');
        }
      } else {
        // throw  Exception(e.toString());
        throw ServerFailure(e.toString());
      }
    }
  }

  // put method
  Future<Map<String, dynamic>> put(
      {required String endPoint,
      required Map<String, dynamic> data,
      Map<String, String>? headers}) async {
    try {
      var response = await _dio.put('$baseUrl$endPoint',
          data: data, options: Options(headers: headers));

      return response.data;
    } catch (error, stacktrace) {
      // Handle any error that occurs during the request
      // print('Error: $error');
      // print('Stacktrace: $stacktrace');
      throw Exception(
          'Failed to make PUT request , Error: $error , Stacktrace: $stacktrace ');
    }
  }

  // patch method
  Future<Map<String, dynamic>> patch(
      {required String endPoint,
      required Map<String, dynamic> data,
      Map<String, String>? headers}) async {
    try {
      var response = await _dio.patch('$baseUrl$endPoint',
          data: data, options: Options(headers: headers));

      return response.data;
    } catch (error, stacktrace) {
      // Handle any error that occurs during the request
      // print('Error: $error');
      // print('Stacktrace: $stacktrace');
      throw Exception(
          'Failed to make PATCH request , Error: $error , Stacktrace: $stacktrace ');
    }
  }

  // delete method
  Future<Map<String, dynamic>> delete(
      {required String endPoint, Map<String, String>? headers}) async {
    try {
      var response = await _dio.delete('$baseUrl$endPoint',
          options: Options(headers: headers));

      return response.data;
    } catch (error, stacktrace) {
      // Handle any error that occurs during the request
      // print('Error: $error');
      // print('Stacktrace: $stacktrace');
      throw Exception(
          'Failed to make DELETE request , Error: $error , Stacktrace: $stacktrace ');
    }
  }

  Future<Map<String, dynamic>> postRequestWithFiles({
    required String endPoint,
    required Map<String, dynamic> data,
    required List<File> imageFiles,
    required File pdfFile,
    Map<String, String>? headers,
  }) async {
    try {
      FormData formData = FormData.fromMap(data);

      // Add image files to the form data
      if (imageFiles.isEmpty != true) {
        // formData.fields.add(const MapEntry("images", ""));
        // }
        for (var file in imageFiles) {
          String fileName = file.path.split('/').last;
          formData.files.add(MapEntry(
            "Images",
            await MultipartFile.fromFile(file.path, filename: fileName),
          ));
        }
      }
      // Add an empty value for "images" if no image files are provided
      // if (imageFiles.isEmpty) {
      //   formData.fields.add(const MapEntry("images", ""));
      // }

      // Add the PDF file to the form data
      // String pdfFileName = pdfFile.path.split('/').last;
      // formData.files.add(MapEntry(
      //   "FilePDF",
      //   await MultipartFile.fromFile(pdfFile.path, filename: pdfFileName),
      // ));
      // // Add an empty value for "FilePDF" if no PDF file is provided
      // if (pdfFile.path.isEmpty || pdfFile == null) {
      //   formData.fields.add(const MapEntry("FilePDF", ""));
      // }

      var response = await _dio.post('$baseUrl$endPoint',
          data: formData, options: Options(headers: headers));

      return response.data;
    } catch (error, stacktrace) {
      throw Exception(
          'Failed to make POST request with files, Error: $error , Stacktrace: $stacktrace');
    }
  }
}
