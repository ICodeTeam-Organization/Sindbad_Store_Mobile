import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/services/api_service.dart';
import 'package:sindbad_management_app/core/services/new_api_service.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/profile_data_source.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/profile_model/profile_model.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/update_profiel_model.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/edit_profile_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/get_profile_data_entity.dart';

class ProfileDataSourceImpl implements ProfileDataSource {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final ApiService apiService;
  final NewApiService newApiService;

  ProfileDataSourceImpl(this.apiService, this.newApiService);

  /// Handles DioException and other errors, throwing a meaningful exception
  Never _handleError(dynamic error, String operation) {
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode;
      final errorData = response?.data;

      String message;
      if (errorData is Map) {
        message = errorData['error'] ??
            errorData['message'] ??
            'Failed to $operation';
      } else {
        message = error.message ?? 'Failed to $operation';
      }

      throw Exception('[$statusCode] $message');
    }
    throw Exception('Failed to $operation: $error');
  }

  /// Extracts the store ID from the JWT token payload
  Future<String?> extractStoreIdFromToken() async {
    final token = await secureStorage.read(key: 'token');
    if (token == null || token.isEmpty) {
      throw Exception("No token found in secure storage");
    }

    // Decode the token
    final decodedToken = JwtDecoder.decode(token);

    // Check for storeId or Id key
    final storeId = decodedToken["storeId"] ?? decodedToken["Id"];
    if (storeId == null) {
      throw Exception("Token does not contain a store ID");
    }

    return storeId.toString();
  }

  @override
  Future<EditProfileEntity> editProfile(
      String name, String email, String phone, String telePhone) async {
    String? token = await secureStorage.read(key: 'token');
    var data = await apiService.put(
        data: {'name': name, 'email': email, 'telePhone': telePhone},
        endPoint: 'Customer/profile',
        headers: {'Authorization': 'Bearer $token'});
    return UpdateProfielModel.fromJson(data);
  }

  @override
  Future<GetProfileDataEntity> getProfileData() async {
    try {
      String? storeId = await extractStoreIdFromToken();

      // Using NewApiService - token is auto-injected via AuthInterceptor
      final response = await newApiService.dio.get('Stores/$storeId');
      GetProfileDataEntity profileData =
          ProfileModel.fromJson(response.data['data']['items'][0]);
      return profileData;
    } catch (e) {
      _handleError(e, 'get profile data');
    }
  }

  @override
  Future<Either<Failure, List<StoreCategoryModel>>> getStoreCategory() {
    // TODO: implement getStoreCategory
    throw UnimplementedError();
  }
}
