import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/api_service.dart';
import '../../domain/entities/sign_in_entity.dart';
import '../models/sign_in_model/sign_in_model.dart';

abstract class SignInRemotDataSource {
  Future<SignInEntity> signIn(String email, String password);
}

class SignInRemoteDataSourceImpl implements SignInRemotDataSource {
  final ApiService apiService;
  final FlutterSecureStorage secureStorage;
  SignInRemoteDataSourceImpl(this.apiService, this.secureStorage);

  // get Token Function
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  @override
  Future<SignInEntity> signIn(String phoneNumber, String password) async {
    var data = await apiService.post(
      endPoint: "Auth/loginAsync",
      data: {
        'password': password,
        'phoneNumber': phoneNumber,
      },
    );

    SignInEntity userVerification = SignInModel.fromJson(data);

    if (userVerification.isSuccess == true && userVerification.token != null) {
      await secureStorage.write(key: 'token', value: userVerification.token);
    }

    print(userVerification);
    return userVerification;
  }
}
