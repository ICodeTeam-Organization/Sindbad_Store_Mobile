import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/setup_service_locator.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/usecases/delete_product_by_id_use_case.dart';
import '../../domain/usecases/get_main_category_for_view_use_case.dart';
import '../../domain/usecases/get_products_by_filter_use_case.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'view_product.dart';

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
          DeleteProductByIdUseCase(
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
    ], child: ListMainCategoryForTabView());
  }
}
