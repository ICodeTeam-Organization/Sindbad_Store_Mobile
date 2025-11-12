import 'package:flutter_test/flutter_test.dart';
import 'package:sindbad_management_app/core/models/responsive_model.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_soure_imp.dart';

void main() {
  // ✅ THIS IS REQUIRED
  // test('Real API Test - Confirm Code', () async {
  //   final authRepository = AuthRemoteDataSourceImpl();

  //   print('🚀 Testing confirmCode with real API...');

  //   const phoneNumber = "777777778";
  //   const code = "123456";

  //   final result = await authRepository.confirmCode(phoneNumber, code);
  //   expect();
  // });
  test("test if number is valid", () async {
    final authRepository = AuthRemoteDataSourceImpl();
    const phoneNumber = "777777778";
    const code = "123456";

    final result = await authRepository.confirmCode(phoneNumber, code);
    print(result);
    expect(result, ResponseModel);
  });

  // test('Real API Test - Forget Password', () async {
  //   final authRepository = AuthRepositoryImpl();

  //   print('🚀 Testing foregetPassword with real API...');

  //   const phoneNumber = "777777778";
  //   const newPassword = "newPassword123";

  //   final result = await authRepository.foregetPassword(phoneNumber, newPassword);

  //   result.fold(
  //     (error) {
  //       print('❌ Error: $error');
  //       expect(true, true);
  //     },
  //     (success) {
  //       print('✅ Success: $success');
  //       expect(true, true);
  //     },
  //   );
  // });
}
