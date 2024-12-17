import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_else_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_failure_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_initial_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_loading_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_success_widget.dart';
import '../../../../core/styles/text_style.dart';
import '../domain/entities/main_category_entity.dart';
import '../ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class CustomCardToAllDropDown extends StatelessWidget {
  const CustomCardToAllDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Container(
        width: 363.0.w,
        // height: 356.0.h,
        height: 440.0.h,
        decoration: BoxDecoration(
            // border: Border.all(width: 2.0.w, color: Colors.black),
            ),
        margin: EdgeInsets.only(bottom: 20.0.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // container Title
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 14.0.h, top: 10.h, right: 14.0.w),
                child: Text(
                  " نوع المنتج",
                  style: KTextStyle.textStyle16
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            BlocBuilder<GetCategoryNamesCubit, GetCategoryNamesState>(
              builder: (context, state) {
                if (state is GetCategoryNamesInitial) {
                  // عند فتح الصفحة قبل تنفيذ دالة الجلب لابد أن تعطية شكل إفتراضي
                  return const GetCategoryNamesInitialWidget();
                }
                if (state is GetCategoryNamesLoading) {
                  print("جارررررررررررررررررررررررري التحميييييييييييييييل");
                  return const GetCategoryNamesLoadingWidget();
                }
                if (state is GetCategoryNamesSuccess) {
                  // shortuct to access [AddProductToStoreCubit]
                  final AddProductToStoreCubit cubitAddProduct =
                      context.read<AddProductToStoreCubit>();
                  // shortuct to access [GetCategoryNamesCubit]
                  final GetCategoryNamesCubit cubitCategories =
                      context.read<GetCategoryNamesCubit>();

                  final List<MainCategoryEntity> mainAndSubCategories =
                      state.categoryAndSubCategoryNames;

                  cubitAddProduct.selectedSubCategoryId =
                      cubitCategories.selectedSubCategories.isNotEmpty
                          ? cubitCategories
                              .selectedSubCategories.first.subCategoryId
                          : null;

                  return GetCategoryNamesSuccessWidget(
                      mainAndSubCategories: mainAndSubCategories,
                      cubitCategories: cubitCategories,
                      cubitAddProduct: cubitAddProduct);
                }

                if (state is GetCategoryNamesFailure) {
                  print("فششششششششششششششل التحميييييييييييييييل");
                  print(state.errMessage);

                  return const GetCategoryNamesFailureWidget();
                }
                // عند حدوث خطأ غير معروف
                return const GetCategoryNamesElseWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
