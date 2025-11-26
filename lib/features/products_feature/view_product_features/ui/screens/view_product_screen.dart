import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/activate_products_by_ids_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';
import '../../../../../injection_container.dart';
import '../../../add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import '../../../add_and_edit_product_feature/domain/use_cases/get_product_details_to_store_use_case.dart';
import '../../../add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/use_cases/delete_product_by_id_use_case.dart';
import '../../domain/use_cases/get_main_category_for_view_use_case.dart';
import '../manager/activate_products/activate_products_by_ids_cubit.dart';
import '../manager/delete_product_by_id_from_store/delete_product_by_id_from_store_cubit.dart';
import '../manager/disable_products/disable_products_by_ids_cubit.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import '../widgets/body_view_product.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      // GetStoreProductsWithFilterCubit is already provided in main.dart (root widget)
      BlocProvider(
        create: (context) =>
            GetMainCategoryForViewCubit(GetMainCategoryForViewUseCase(
          getit.get<ViewProductRepoImpl>(),
        )),
      ),
      BlocProvider(
        create: (context) =>
            DisableProductsByIdsCubit(DisableProductsByIdsUseCase(
          getit.get<ViewProductRepoImpl>(),
        )),
      ),
      BlocProvider(
        create: (context) => DeleteProductByIdFromStoreCubit(
          DeleteProductByIdUseCase(
            getit.get<ViewProductRepoImpl>(),
          ),
        ),
      ),
      BlocProvider(
          create: (context) =>
              ActivateProductsByIdsCubit(ActivateProductsByIdsUseCase(
                getit.get<ViewProductRepoImpl>(),
              ))),
      BlocProvider(
          create: (context) =>
              ProductDetailsCubit(GetProductDetailsToStoreUseCase(
                getit.get<AddAndEditProductStoreRepoImpl>(),
              ))),
    ], child: BodyViewProductScreen());
  }
}
