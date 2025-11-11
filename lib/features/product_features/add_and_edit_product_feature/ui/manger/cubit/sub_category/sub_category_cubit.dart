import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import '../../../../domain/entities/add_product_entities/sub_category_entity.dart';

class SubCategoryCubit extends Cubit<List<CategoryEntity>> {
  SubCategoryCubit() : super([]);
  void updateSubCategories({required List<CategoryEntity> subCategories}) {
    emit(subCategories);
  }
}
