import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/usecases/disable_products_by_ids_use_case.dart';
import '../../../../../core/setup_service_locator.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/usecases/delete_product_by_id_use_case.dart';
import '../../domain/usecases/get_main_category_for_view_use_case.dart';
import '../../domain/usecases/get_products_by_filter_use_case.dart';
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
        create: (context) =>
            GetMainCategoryForViewCubit(GetMainCategoryForViewUseCase(
          getit.get<ViewProductStoreRepoImpl>(),
        )),
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
    ], child: BodyViewProductScreen());
  }
}
