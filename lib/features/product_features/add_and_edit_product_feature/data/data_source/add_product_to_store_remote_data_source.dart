import 'package:sindbad_management_app/core/api_service.dart';
import '../../domain/entities/brand_entity.dart';
import '../../domain/entities/main_category_entity.dart';
import '../models/brand_model/datum.dart';
import '../models/main_and_sub_category_model/item.dart';

abstract class AddProductToStoreRemoteDataSource {
  Future<List<MainCategoryEntity>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  });
  Future<List<BrandEntity>> getBrandsByMainCategoryId({
    required int mainCategoryId,
  });
}

class AddProductToStoreRemoteDataSourceImpl
    extends AddProductToStoreRemoteDataSource {
  final ApiService apiService;

  AddProductToStoreRemoteDataSourceImpl(this.apiService);

  // =========================  for get MainAndSubCategory  ===========================
  @override
  Future<List<MainCategoryEntity>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  }) async {
    final Map<String, dynamic> data = await apiService.get(
        endPoint:
            "Categories/GetCategoriesWithFilter?filterType=$filterType&pageSize=$pageSize&pageNumber=$pageNumper");

    // change Data from JSON to DartModel
    List<MainCategoryEntity> changeToDartModel(List<dynamic> data) {
      List<MainCategoryEntity> mainCategoryEntity = data
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList();
      return mainCategoryEntity;
    }

    List<MainCategoryEntity> mainAndSubCategores =
        changeToDartModel(data['data']['items'] as List<dynamic>);
    return mainAndSubCategores;
  }

  // =============================  for get Brands  ==================================
  @override
  Future<List<BrandEntity>> getBrandsByMainCategoryId(
      {required int mainCategoryId}) async {
    final Map<String, dynamic> data = await apiService.get(
        endPoint: "Brands/GetBrandsByMainCategory/$mainCategoryId");

    // fun change Data from JSON to DartModel
    List<BrandEntity> changeToDartModel(List<dynamic> data) {
      List<BrandEntity> brandsEntity = data
          .map((datum) => Datum.fromJson(datum as Map<String, dynamic>))
          .toList();
      return brandsEntity;
    }

    List<BrandEntity> brands = changeToDartModel(data['data'] as List<dynamic>);
    print("================ in data source =====================");
    print(brands);
    print("================ in data source =====================");
    return brands;
  }
}
