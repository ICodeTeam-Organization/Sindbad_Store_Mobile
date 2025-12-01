import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/repo/store_data_source.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

class StoreDataSourceImpl implements StoreDataSource {
  final FlutterSecureStorage secureStorage;
  // final Dio apiService;

  StoreDataSourceImpl(this.secureStorage);

  @override
  Future<List<StoreCategoryModel>> getStoreCategories() async {
    try {
      String? token = await secureStorage.read(key: 'token');

      final response = await Dio().get(
        'https://www.sindibad-back.com:82/api/Stores?owned=true',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        final json = response.data;

        // Success check
        if (json["success"] != true) {
          throw Exception(json["message"] ?? "Unknown error");
        }

        // Extract items list
        final items = json["data"]["items"] as List;

        if (items.isEmpty) return []; // no items found

        // Extract the first item's storeCategoriesIds
        final categoriesJson = items[0]["storeCategoriesIds"] as List;

        return categoriesJson
            .map((e) => StoreCategoryModel.fromJson(e))
            .toList();
      } else {
        throw Exception(
            "Server responded with status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to load store categories: $e");
    }
  }
}
