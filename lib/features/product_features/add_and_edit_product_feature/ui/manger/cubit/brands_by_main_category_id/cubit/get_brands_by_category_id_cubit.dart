import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';

import '../../../../../../../../core/errors/failure.dart';
import '../../../../../domain/use_cases/get_brands_by_main_category_id_use_case.dart';

part 'get_brands_by_category_id_state.dart';

class GetBrandsByCategoryIdCubit extends Cubit<GetBrandsByCategoryIdState> {
  GetBrandsByCategoryIdCubit(this.getBrandsByMainCategoryIdUseCase)
      : super(GetBrandsByCategoryIdInitial());

  final GetBrandsByMainCategoryIdUseCase getBrandsByMainCategoryIdUseCase;

  void getBrandsByMainCategoryId({required int mainCategoryId}) async {
    emit(GetBrandsByCategoryIdLoading());
    GetBrandsByMainCategoryIdParams params =
        GetBrandsByMainCategoryIdParams(mainCategoryId: mainCategoryId);
    Either<Failure, List<BrandEntity>> result =
        await getBrandsByMainCategoryIdUseCase.execute(params);

    result.fold(
        // left
        (failure) {
      emit(GetBrandsByCategoryIdFailure());
    },
        // right
        (brands) {
      emit(GetBrandsByCategoryIdSuccess(brands: brands));
    });
  }
}
