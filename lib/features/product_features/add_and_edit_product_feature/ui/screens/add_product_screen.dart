import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/injection_container.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/add_product_screen_body.dart';
import '../../data/repos/add_and_edit_product_store_repo_impl.dart';
import '../../domain/use_cases/add_product_to_store_use_case.dart';
import '../../domain/use_cases/get_brands_by_main_category_id_use_case.dart';
import '../../domain/use_cases/get_main_and_sub_category_use_case.dart';
import '../manger/cubit/attribute_product/attribute_product_cubit.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class AddProductScreen extends StatelessWidget {
  final VoidCallback? onSuccessCallback;
  const AddProductScreen({super.key, this.onSuccessCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // =========  initialize BlocProvider for Add Product Screen ==========
          child: MultiBlocProvider(
            providers: [
              //for add product
              BlocProvider(
                  create: (context) =>
                      AddProductToStoreCubit(AddProductToStoreUseCase(
                        addProductStoreRepo:
                            getit.get<AddAndEditProductStoreRepoImpl>(),
                      ))),
              BlocProvider(
                  create: (context) =>
                      GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
                        getit.get<AddAndEditProductStoreRepoImpl>(),
                      ))),
              BlocProvider(
                  create: (context) => GetBrandsByCategoryIdCubit(
                          GetBrandsByMainCategoryIdUseCase(
                        getit.get<AddAndEditProductStoreRepoImpl>(),
                      ))),
              BlocProvider(create: (context) => AttributeProductCubit()),
            ],
            child: AddProductScreenBody(onSuccessCallback: onSuccessCallback),
          ),
        ),
      ),
    );
  }
}
