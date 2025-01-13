import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_else_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_failure_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_initial_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_loading_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_success_widget.dart';
import '../../../../../core/styles/text_style.dart';
import '../../domain/entities/add_product_entities/main_category_entity.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class CustomCardToAllDropDown extends StatelessWidget {
  const CustomCardToAllDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ==================== call fun fetch Main And Sub Category  ==============
    context
        .read<GetCategoryNamesCubit>()
        .getMainAndSubCategory(filterType: 2, pageNumper: 1, pageSize: 100);

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
