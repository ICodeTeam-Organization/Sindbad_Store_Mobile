import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/use_cases/get_main_and_sub_category_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/use_cases/activate_products_by_ids_use_case.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';
import '../../../../../core/setup_service_locator.dart';
import '../../../add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import '../../../add_and_edit_product_feature/domain/use_cases/get_product_details_to_store_use_case.dart';
import '../../../add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/use_cases/delete_product_by_id_use_case.dart';
import '../../domain/use_cases/get_main_category_for_view_use_case.dart';
import '../../domain/use_cases/get_products_by_filter_use_case.dart';
import '../manager/activate_products/activate_products_by_ids_cubit.dart';
import '../manager/delete_product_by_id_from_store/delete_product_by_id_from_store_cubit.dart';
import '../manager/disable_products/disable_products_by_ids_cubit.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import '../widgets/body_view_product.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => GetStoreProductsWithFilterCubit(
          GetProductsByFilterUseCase(
            getit.get<ViewProductStoreRepoImpl>(),
          ),
        ),
      ),
      BlocProvider(
        create: (context) => GetCategoryNamesCubit(
          GetMainAndSubCategoryUseCase(
            getit.get<AddAndEditProductStoreRepoImpl>(),
          ),
        ),
      ),
      BlocProvider(
        create: (context) =>
            DisableProductsByIdsCubit(DisableProductsByIdsUseCase(
          getit.get<ViewProductStoreRepoImpl>(),
        )),
      ),
      BlocProvider(
        create: (context) => DeleteProductByIdFromStoreCubit(
          DeleteProductByIdUseCase(
            getit.get<ViewProductStoreRepoImpl>(),
          ),
        ),
      ),
      BlocProvider(
          create: (context) =>
              ActivateProductsByIdsCubit(ActivateProductsByIdsUseCase(
                getit.get<ViewProductStoreRepoImpl>(),
              ))),
      BlocProvider(
          create: (context) =>
              ProductDetailsCubit(GetProductDetailsToStoreUseCase(
                getit.get<AddAndEditProductStoreRepoImpl>(),
              ))),
    ], child: BodyViewProductScreen());
  }
}
