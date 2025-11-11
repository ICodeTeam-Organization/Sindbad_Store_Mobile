// import 'package:flutter_test/flutter_test.dart';
// import 'package:dio/dio.dart';
// import 'package:sindbad_management_app/core/models/response_error.dart';
// import 'package:sindbad_management_app/core/models/responsive_model.dart';
// import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_soure_imp.dart';

// void main() {
//   late AuthRemoteDataSourceImpl dataSource;

//   setUp(() {
//     dataSource = AuthRemoteDataSourceImpl();
//   });

//   test('should confirm code with real API', () async {
//     // Replace with real phone and code that works
//     const phoneNumber = "123456789";
//     const code = "1234";

//     try {
//       final result = await dataSource.confirmCode(phoneNumber, code);
//       print("Success: ${result.message}");
//       expect(result, isA<ResponseModel>());
//     } on ResponseError catch (e) {
//       print("Error: ${e.message}");
//       fail("API returned an error: ${e.message}");
//     } catch (e) {
//       print("Unexpected error: $e");
//       fail("Unexpected exception occurred");
//     }
//   });
// }
