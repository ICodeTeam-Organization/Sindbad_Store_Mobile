import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../data/repos/add_product_store_repo_impl.dart';
import '../../domain/usecases/add_product_to_store_use_case.dart';
import '../../domain/usecases/get_brands_by_main_category_id_use_case.dart';
import '../../domain/usecases/get_main_and_sub_category_use_case.dart';
import '../../widgets/custom_card_to_all_attributes_fileds.dart';
import '../../widgets/custom_card_to_all_drop_down.dart';
import '../../widgets/custom_card_to_all_images.dart';
import '../../widgets/custom_card_to_all_text_fileds.dart';
import '../../widgets/two_button_in_down_add_product.dart';
import '../manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import '../manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // =========  initilize BlocProvider for Add Product Screen ==========
          child: MultiBlocProvider(
            providers: [
              //for add product
              BlocProvider(
                  create: (context) =>
                      AddProductToStoreCubit(AddProductToStoreUseCase(
                        addProductStoreRepo:
                            getit.get<AddProductStoreRepoImpl>(),
                      ))),
              BlocProvider(create: (context) => AddImageToProductAddCubit()),
              BlocProvider(
                  create: (context) =>
                      GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
                        getit.get<AddProductStoreRepoImpl>(),
                      ))),
              BlocProvider(
                  create: (context) => GetBrandsByCategoryIdCubit(
                          GetBrandsByMainCategoryIdUseCase(
                        getit.get<AddProductStoreRepoImpl>(),
                      ))),
              BlocProvider(create: (context) => AddAttributeProductDartCubit()),
              //
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  isSearch: false,
                  tital: 'إضافة منتج',
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //  ================= for text filed =========
                        CustomCardToAllTextFileds(),
                        SizedBox(height: 26.h),
                        //  ================= for Add Images =========
                        CustomCardToAllImages(),
                        SizedBox(height: 26.h),
                        //  ================= for drop down =========
                        CustomCardToAllDropDown(),
                        SizedBox(height: 26.h),
                        //  ================= for Attributes Fileds =========
                        CustomCardToAllAttributesFileds(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // for tow Button in down
                TwoButtonInDownAddproduct(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
