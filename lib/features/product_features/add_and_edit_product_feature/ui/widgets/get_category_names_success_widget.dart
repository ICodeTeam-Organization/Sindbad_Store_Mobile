import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget_for_state_cubit.dart';

class GetCategoryNamesSuccessWidget extends StatelessWidget {
  const GetCategoryNamesSuccessWidget({
    super.key,
    required this.mainAndSubCategories,
    required this.cubitCategories,
    required this.cubitAddProduct,
  });

  final List<MainCategoryEntity> mainAndSubCategories;
  final GetCategoryNamesCubit cubitCategories;
  final AddProductToStoreCubit cubitAddProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // =================  Main Category ================
        CustomDropdownWidget(
          enabled: true,
          textTitle: 'أختر الفئة',
          hintText: "قم بإختيار الفئة المناسبة",
          initialItem: null,
          items: mainAndSubCategories.isNotEmpty
              ? mainAndSubCategories
                  .map((category) => category.mainCategoryName)
                  .toList()
              : [],
          onChanged: (value) {
            int selectedIndex = mainAndSubCategories
                .indexWhere((category) => category.mainCategoryName == value);
            if (selectedIndex != -1) {
              final int selectedMainCategoryId =
                  mainAndSubCategories[selectedIndex].mainCategoryId;

              cubitCategories.updateSubCategories(
                  selectedMainCategoryId); // refresh sub categories
              context
                  .read<GetBrandsByCategoryIdCubit>()
                  .getBrandsByMainCategoryId(
                      mainCategoryId: selectedMainCategoryId);

              cubitAddProduct.selectedMainCategoryId =
                  mainAndSubCategories[selectedIndex].mainCategoryId;

              cubitAddProduct.selectedSubCategoryId = null;
              cubitAddProduct.selectedBrandId = null;
            }
          },
        ),
        SizedBox(height: 10),

        // =================  Sub Category ================
        CustomDropdownWidget(
          enabled:
              cubitAddProduct.selectedMainCategoryId == null ? false : true,
          textTitle: 'أختر القسم',
          hintText: "إختر الفئة الأساسية أولا",
          initialItem: cubitCategories.selectedSubCategories.isNotEmpty
              ? cubitCategories
                  .selectedSubCategories.first.subCategoryNameEntity
              : null,
          items: cubitCategories.selectedSubCategories.isNotEmpty
              ? cubitCategories.selectedSubCategories
                  .map((subCategory) => subCategory.subCategoryNameEntity)
                  .toList()
              : [],
          onChanged: (value) {
            cubitAddProduct.selectedSubCategoryId = cubitCategories
                .selectedSubCategories
                .firstWhere((subCategories) =>
                    subCategories.subCategoryNameEntity == value)
                .subCategoryId;
          },
        ),
        SizedBox(height: 10),
        // ===========================  for Brand  =======================
        BlocBuilder<GetBrandsByCategoryIdCubit, GetBrandsByCategoryIdState>(
          builder: (context, state) {
            if (state is GetBrandsByCategoryIdInitial) {
              return CustomDropdownWidgetForStateCubit(
                  textTitle: 'أختر اسم البراند',
                  hintText: "إختر الفئة الأساسية أولا");
            }
            if (state is GetBrandsByCategoryIdLoading) {
              return CustomDropdownWidgetForStateCubit(
                  textTitle: 'أختر اسم البراند', hintText: "جاري التحميل...");
            }
            if (state is GetBrandsByCategoryIdSuccess) {
              final List<BrandEntity> brandsWithNoFound = [
                BrandEntity(brandId: 000, brandNameEntity: "لا يوجد")
              ];
              brandsWithNoFound.addAll(state.brands);

              return CustomDropdownWidget(
                enabled: true,
                textTitle: 'أختر اسم البراند',
                hintText: "قم بإختيار البراند المناسب",
                initialItem: null,
                items: brandsWithNoFound
                    .map((category) => category.brandNameEntity)
                    .toList(),
                onChanged: (value) {
                  int selectedIndex = brandsWithNoFound.indexWhere(
                      (brandsWithNoFound) =>
                          brandsWithNoFound.brandNameEntity == value);

                  if (selectedIndex > 0) {
                    cubitAddProduct.selectedBrandId =
                        brandsWithNoFound[selectedIndex].brandId;
                  } else {
                    cubitAddProduct.selectedBrandId = null;
                  }
                },
              );
            }
            if (state is GetBrandsByCategoryIdFailure) {}
            return CustomDropdownWidget(
              enabled: false,
              textTitle: 'أختر إسم البراند',
              hintText: "قم بإختيار البراند المناسب",
              items: [],
              onChanged: (value) => null,
            );
          },
        )
      ],
    );
  }
}
