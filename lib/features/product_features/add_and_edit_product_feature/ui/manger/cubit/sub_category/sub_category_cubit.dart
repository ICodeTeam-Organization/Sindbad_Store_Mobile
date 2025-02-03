import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/add_product_entities/sub_category_entity.dart';

class SubCategoryCubit extends Cubit<List<SubCategoryEntity>> {
  SubCategoryCubit() : super([]);
  void updateSubCategories({required List<SubCategoryEntity> subCategories}) {
    emit(subCategories);
  }
}
