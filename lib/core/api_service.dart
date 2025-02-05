import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'errors/failure.dart';

class ApiService {
  final Dio _dio;
  final baseUrl = "https://sindibad-shop.com:82/api/";

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

  // put With Files method
  Future<Map<String, dynamic>> putWithFilesForEditProduct(
      {required String endPoint,
      required Map<String, dynamic> data,
      List<File?>? imageFiles,
      File? imageFile,
      Map<String, String>? headers}) async {
    try {
      FormData formData = FormData.fromMap(data);
      if (data.keys.contains("newAttributes")) {
        formData.fields
            .removeWhere((item) => item.key.contains("newAttributes"));
        for (var i = 0; i < data["newAttributes"].length; i++) {
          formData.fields.add(MapEntry("newAttributes[$i].attributeName",
              data["newAttributes"][i]["attributeName"]));
          formData.fields.add(MapEntry("newAttributes[$i].attributeValue",
              data["newAttributes"][i]["attributeValue"]));
        }
      }
      // Add an empty value for "images" if no image files are provided
      if (imageFiles == null) {
        // formData.fields.add(const MapEntry("Images", ''));
      }
      // Add image files to the form data
      else if (imageFiles.isNotEmpty) {
        // formData.fields.add(const MapEntry("images", ""));
        // }
        for (var file in imageFiles) {
          String fileName = file!.path.split('/').last;
          formData.files.add(MapEntry(
            "Images",
            await MultipartFile.fromFile(file.path, filename: fileName),
          ));
        }
      }
      // // Add an empty value for "images" if no image files are provided
      // if (imageFiles.isEmpty) {
      //   formData.fields.add(const MapEntry("Images", ""));
      // }
      // // Add an empty value for "FilePDF" if no PDF file is provided
      // if (imageFile == null) {
      //   // formData.fields.add(const MapEntry("MainImage", ""));
      // }
      if (imageFile != null) {
        // Add the  file to the form data
        String fileName = imageFile.path.split('/').last;
        formData.files.add(MapEntry(
          "MainImage",
          await MultipartFile.fromFile(imageFile.path, filename: fileName),
        ));
      }

      // // // Add an empty value for "FilePDF" if no PDF file is provided
      // if (imageFile.path.isEmpty || imageFile == null) {
      //   formData.fields.add(const MapEntry("MainImage", ""));
      // }
      var response = await _dio.put('$baseUrl$endPoint',
          data: formData, options: Options(headers: headers));

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

  // patch for using disable or activate products (abdullah) method
  Future<Map<String, dynamic>> patchForDisableOrActivateProductsOnly(
      {required String endPoint,
      required List<int> data,
      Map<String, String>? headers}) async {
    try {
      var response = await _dio.patch('$baseUrl$endPoint',
          // data: data,
          data: jsonEncode(data),
          options: Options(
              // headers: headers
              headers: {
                ...?headers,
                'Content-Type': 'application/json',
              }));

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
    required File file,
  }) async {
    try {
      FormData formData = FormData.fromMap(data);
      if (data.keys.contains("newAttributes")) {
        formData.fields
            .removeWhere((item) => item.key.contains("newAttributes"));
        for (var i = 0; i < data["newAttributes"].length; i++) {
          formData.fields.add(MapEntry("newAttributes[$i].attributeName",
              data["newAttributes"][i]["attributeName"]));
          formData.fields.add(MapEntry("newAttributes[$i].attributeValue",
              data["newAttributes"][i]["attributeValue"]));
        }
      }
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

      // Add the  file to the form data
      String fileName = file.path.split('/').last;
      formData.files.add(MapEntry(
        "MainImage",
        await MultipartFile.fromFile(file.path, filename: fileName),
      ));
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

  Future<Map<String, dynamic>> postRequestWithFileAndImage({
    required String endPoint,
    required Map<String, dynamic> data,
    required File file,
    Map<String, String>? headers,
  }) async {
    try {
      FormData formData = FormData();

      // Print the entire data map for debugging
      print('Data provided: $data');

      // Check if Date is present and valid

      // Add invoice date
      if (data.containsKey('Date')) {
        formData.fields.add(MapEntry('Date', data['Date'].toString()));
      } else {
        throw Exception('Date is required');
      }
      // Add invoice number
      if (data.containsKey('InvoiceNumber')) {
        formData.fields
            .add(MapEntry('InvoiceNumber', data['InvoiceNumber'].toString()));
      } else {
        throw Exception('InvoiceNumber is required');
      }
      // Add orderDetailsId
      if (data.containsKey('packageId')) {
        formData.fields
            .add(MapEntry('packageId', data['packageId'].toString()));
      } else {
        throw Exception('packageId is required');
      }
      // Add invoice Amount and amount
      if (data.containsKey('InvoiceAmount')) {
        formData.fields
            .add(MapEntry('InvoiceAmount', data['InvoiceAmount'].toString()));
      } else {
        throw Exception('InvoiceAmount is required');
      }
      // Add invoice Type and amount
      if (data.containsKey('InvoiceType')) {
        formData.fields
            .add(MapEntry('InvoiceType', data['InvoiceType'].toString()));
      } else {
        throw Exception('InvoiceType is required');
      }
      if (data.containsKey('CompanyName')) {
        formData.fields
            .add(MapEntry('CompanyName', data['CompanyName'].toString()));
      } else {
        throw Exception('CompanyName is required');
      }
      if (data.containsKey('ParcelNumber')) {
        formData.fields
            .add(MapEntry('ParcelNumber', data['ParcelNumber'].toString()));
      } else {
        throw Exception('ParcelNumber is required');
      }
      if (data.containsKey('ShippingCompniesId')) {
        formData.fields.add(MapEntry(
            'ShippingCompniesId', data['ShippingCompniesId'].toString()));
      } else {
        return {};
      }
      if (data.containsKey('PhoneNumper')) {
        formData.fields
            .add(MapEntry('PhoneNumper', data['PhoneNumper'].toString()));
      } else {
        return {};
      }

      // Check the file
      if (file.existsSync()) {
        String fileName = file.path.split('/').last;
        formData.files.add(MapEntry(
          "InvoiceImage",
          await MultipartFile.fromFile(file.path, filename: fileName),
        ));
      } else {
        throw Exception('File does not exist');
      }

      // Make the POST request
      var response = await _dio.post('$baseUrl$endPoint',
          data: formData, options: Options(headers: headers));
      print('Response: ${response.data}');
      return response.data;
    } catch (error, stacktrace) {
      throw Exception(
          'Failed to make POST request with files, Error: $error, Stacktrace: $stacktrace');
    }
  }
}
