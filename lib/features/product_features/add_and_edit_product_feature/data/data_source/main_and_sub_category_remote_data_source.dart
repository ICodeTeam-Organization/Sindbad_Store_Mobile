import 'package:sindbad_management_app/core/api_service.dart';
import '../../domain/entities/main_category_entity.dart';
import '../models/main_and_sub_category_model/item.dart';

abstract class MainAndSubCategoryRemoteDataSource {
  Future<List<MainCategoryEntity>> getMainAndSubCategory({
    required int filterType,
    required int pageNumper,
    required int pageSize,
  });
}

class MainAndSubCategoryRemoteDataSourceImpl
    extends MainAndSubCategoryRemoteDataSource {
  final ApiService apiService;

  MainAndSubCategoryRemoteDataSourceImpl(this.apiService);

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
    } // return mainAndSubCategores

    List<MainCategoryEntity> mainAndSubCategores =
        changeToDartModel(data['data']['items'] as List<dynamic>);
    print("================ in data source =====================");
    print(mainAndSubCategores);
    print("================ in data source =====================");
    return mainAndSubCategores;
  }
}
