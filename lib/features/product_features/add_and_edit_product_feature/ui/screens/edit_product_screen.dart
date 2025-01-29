import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/use_cases/edit_product_from_store_use_case.dart';
import '../../../../../core/setup_service_locator.dart';
import '../../data/repos/add_and_edit_product_store_repo_impl.dart';
import '../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../../domain/use_cases/get_brands_by_main_category_id_use_case.dart';
import '../../domain/use_cases/get_main_and_sub_category_use_case.dart';
import '../manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import '../manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import '../manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import '../manger/cubit/sub_category/sub_category_cubit.dart';
import '../widgets/edit_product_screen_body.dart';

class EditProductScreen extends StatelessWidget {
  final ProductDetailsEntity productDetailsEntity;

  const EditProductScreen({super.key, required this.productDetailsEntity});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
                    getit.get<AddAndEditProductStoreRepoImpl>(),
                  ))),
          BlocProvider(
              create: (context) =>
                  EditProductFromStoreCubit(EditProductFromStoreUseCase(
                    addAndEditProductStoreRepo:
                        getit.get<AddAndEditProductStoreRepoImpl>(),
                  ))),
          BlocProvider(
              create: (context) =>
                  GetBrandsByCategoryIdCubit(GetBrandsByMainCategoryIdUseCase(
                    getit.get<AddAndEditProductStoreRepoImpl>(),
                  ))),
          BlocProvider(create: (context) => AddAttributeProductDartCubit()),
          BlocProvider(create: (context) => SubCategoryCubit()),
        ],
        child: EditProductScreenBody(
          productDetailsEntity: productDetailsEntity,
        ));
  }
}
