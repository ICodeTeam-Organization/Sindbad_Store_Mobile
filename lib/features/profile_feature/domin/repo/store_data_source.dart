import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';

abstract class StoreDataSource {
  Future<List<StoreCategoryModel>> getStoreCategories();
}
