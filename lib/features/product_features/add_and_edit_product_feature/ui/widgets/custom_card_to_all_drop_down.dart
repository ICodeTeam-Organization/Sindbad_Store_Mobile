import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_failure_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_initial_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_loading_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_success_widget.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class CustomCardToAllDropDown extends StatelessWidget {
  final AddProductToStoreCubit cubitAddProduct;
  final GetCategoryNamesCubit cubitCategories;
  const CustomCardToAllDropDown({
    super.key,
    required this.cubitAddProduct,
    required this.cubitCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // container Title
            SectionTitleWidget(title: 'نوع المنتج'),
            SizedBox(height: 20.h),
            BlocBuilder<GetCategoryNamesCubit, GetCategoryNamesState>(
              builder: (context, state) {
                if (state is GetCategoryNamesLoading) {
                  return const GetCategoryNamesLoadingWidget();
                }
                if (state is GetCategoryNamesSuccess) {
                  cubitAddProduct.selectedSubCategoryId =
                      cubitCategories.subCategories.isNotEmpty
                          ? cubitCategories.subCategories.first.categoryId
                          : null;

                  return GetCategoryNamesSuccessWidget(
                      mainAndSubCategories: state.categoryAndSubCategoryNames,
                      cubitCategories: cubitCategories,
                      cubitAddProduct: cubitAddProduct);
                }

                if (state is GetCategoryNamesFailure) {
                  return const GetCategoryNamesFailureWidget();
                }
                return const GetCategoryNamesInitialWidget(); // in else or initial
              },
            ),
          ],
        ),
      ),
    );
  }
}
