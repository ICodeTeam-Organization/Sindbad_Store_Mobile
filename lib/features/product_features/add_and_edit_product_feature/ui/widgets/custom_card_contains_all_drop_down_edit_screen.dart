import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/sub_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget_for_state_cubit.dart';

import '../manger/cubit/sub_category/sub_category_cubit.dart';

class CustomCardContainsAllDropDownEditScreen extends StatefulWidget {
  final int initialMainIdToProduct;
  final int initialSubIdToProduct;
  final int? initialBrandIdToProduct;
  final String initialMainNameToProduct;
  final String initialSubNameToProduct;
  final String? initialBrandNameToProduct;
  const CustomCardContainsAllDropDownEditScreen({
    super.key,
    required this.initialMainIdToProduct,
    required this.initialSubIdToProduct,
    required this.initialBrandIdToProduct,
    required this.initialMainNameToProduct,
    required this.initialSubNameToProduct,
    required this.initialBrandNameToProduct,
  });

  @override
  State<CustomCardContainsAllDropDownEditScreen> createState() =>
      _CustomCardContainsAllDropDownEditScreenState();
}

class _CustomCardContainsAllDropDownEditScreenState
    extends State<CustomCardContainsAllDropDownEditScreen> {
  late final cubitCategories = context.read<GetCategoryNamesCubit>();
  late final cubitEditProduct = context.read<EditProductFromStoreCubit>();

  @override
  void initState() {
    super.initState();
    context
        .read<GetCategoryNamesCubit>()
        .getMainAndSubCategory(filterType: 2, pageNumper: 1, pageSize: 100);
    context.read<GetBrandsByCategoryIdCubit>().getBrandsByMainCategoryId(
        mainCategoryId: widget.initialMainIdToProduct);
  }

  // late GetCategoryNamesCubit cubitCategories;
  //     late EditProductFromStoreCubit cubitEditProduct = context.read<EditProductFromStoreCubit>();

  @override
  Widget build(BuildContext context) {
    // shortcut
    // final cubitCategories = context.read<GetCategoryNamesCubit>();
    // final cubitEditProduct = context.read<EditProductFromStoreCubit>();
    // trigger getMainAndSubCategory
    // cubitCategories.getMainAndSubCategory(
    //     filterType: 2, pageNumper: 1, pageSize: 100);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Container(
        width: 363.w,
        height: 440.h,
        decoration: BoxDecoration(),
        margin: EdgeInsets.only(bottom: 20.h),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 14.h,
                top: 10.h,
                right: 14.w,
              ),
              child: Text(
                " نوع المنتج",
                style: KTextStyle.textStyle16
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          // =======================   Main Category  ========================
          BlocBuilder<GetCategoryNamesCubit, GetCategoryNamesState>(
            // listenWhen: (previous, current) =>
            //     current is GetCategoryNamesSuccess,
            // listener: (context, state) {
            //   // final cubitEditProduct =
            //   //     context.read<EditProductFromStoreCubit>();
            //   if (cubitEditProduct.isInitialDropDown) {
            //     cubitEditProduct.isInitialDropDown = false;
            //   }
            // },
            builder: (context, state) {
              if (state is GetCategoryNamesInitial) {
                return CustomDropdownWidget(
                  // enabled: false,
                  textTitle: 'أختر الفئة',
                  hintText: "قم بإختيار الفئة المناسبة",
                  items: [widget.initialMainNameToProduct],
                  initialItem: widget.initialMainNameToProduct,
                  onChanged: (value) {},
                );
              }

              if (state is GetCategoryNamesSuccess) {
                return CustomDropdownWidget(
                  initialItem: cubitEditProduct.isInitialDropDown
                      ? widget.initialMainNameToProduct
                      : null,
                  textTitle: 'أختر الفئة',
                  hintText: "قم بإختيار الفئة المناسبة",
                  // initialItem:cubitCategories.is,
                  items: state.categoryAndSubCategoryNames.isNotEmpty
                      ? state.categoryAndSubCategoryNames
                          .map((category) => category.mainCategoryName)
                          .toList()
                      : [],
                  onChanged: (value) {
                    //
                    if (cubitEditProduct.isInitialDropDown) {
                      cubitEditProduct.selectedMainCategoryId =
                          widget.initialMainIdToProduct;
                      cubitEditProduct.selectedSubCategoryId =
                          widget.initialSubIdToProduct;
                      cubitEditProduct.selectedBrandId =
                          widget.initialBrandIdToProduct;
                      final selectedMainCategory =
                          state.categoryAndSubCategoryNames.firstWhere(
                        (category) =>
                            category.mainCategoryId ==
                            widget.initialMainIdToProduct,
                      );
                      context.read<SubCategoryCubit>().updateSubCategories(
                          SubCategory: selectedMainCategory.subCategory);
                      // trigger this line after finish line before it
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        cubitEditProduct.isInitialDropDown = false;
                      });
                      return;
                    }
                    // cubitEditProduct.updateIsInitialDropDown();
                    // [get] Index by mainCatNameSelected from list mainAndSubCategories
                    int selectedIndex = state.categoryAndSubCategoryNames
                        .indexWhere(
                            (category) => category.mainCategoryName == value);
                    // [get] Id_Category by selectedIndex from list mainAndSubCategories
                    if (selectedIndex != -1) {
                      final int selectedMainCategoryId = state
                          .categoryAndSubCategoryNames[selectedIndex]
                          .mainCategoryId;

                      final selectedMainCategory =
                          state.categoryAndSubCategoryNames.firstWhere(
                        (category) =>
                            category.mainCategoryId == selectedMainCategoryId,
                      );
                      // selectedSubCategories = contains just sub categories for mainCategories specific by ID
                      context.read<SubCategoryCubit>().updateSubCategories(
                          SubCategory: selectedMainCategory.subCategory);
                      //   // save IdMainCategory in cubit class
                      //   cubitCategories
                      //       .updateSubCategories(selectedMainCategoryId);

                      //   // تحديث فئات الفئة الفرعية
                      //   // cubitCategories
                      //   //     .updateSubCategories(selectedMainCategoryId);

                      //   cubitEditProduct.selectedMainCategoryId =
                      //       selectedMainCategoryId;

                      //   // تحديث البراند
                      context
                          .read<GetBrandsByCategoryIdCubit>()
                          .getBrandsByMainCategoryId(
                              mainCategoryId: selectedMainCategoryId);

                      //   // Initialize [IdSubCategory and IdBrand] in cubit class
                      //   print("============ in on change");
                      // context
                      //     .read<EditProductFromStoreCubit>()
                      //     .isInitialDropDown = false;
                      cubitEditProduct.selectedMainCategoryId =
                          selectedMainCategoryId;
                      cubitEditProduct.selectedSubCategoryId = null;
                      cubitEditProduct.selectedBrandId = null;
                    }
                  },
                );
              }
              return CustomDropdownWidget(
                enabled: false,
                textTitle: 'أختر الفئة',
                hintText: "قم بإختيار الفئة المناسبة",
                items: ["الافتراضي"],
                initialItem: null,
                onChanged: (value) {},
              );
            },
          ),
          // =======================   Sub Category  ========================
          BlocBuilder<SubCategoryCubit, List<SubCategoryEntity>>(
            builder: (context, state) {
              return CustomDropdownWidget(
                enabled: state.isEmpty ? false : true,
                initialItem: state.isEmpty || cubitEditProduct.isInitialDropDown
                    ? widget.initialSubNameToProduct
                    : null,
                textTitle: 'أختر القسم',
                hintText: "قم بإختيار الفئة الفرعية المناسبة",
                items: state.isNotEmpty
                    ? state
                        .map((subCategory) => subCategory.subCategoryNameEntity)
                        .toList()
                    : [widget.initialSubNameToProduct],
                onChanged: (value) {
                  // [get] Index by mainCatNameSelected from list mainAndSubCategories
                  int selectedIndex = state.indexWhere(
                    (subCategory) => subCategory.subCategoryNameEntity == value,
                  );
                  // [get] Id_Category by selectedIndex from list mainAndSubCategories
                  if (selectedIndex != -1) {
                    cubitEditProduct.selectedSubCategoryId =
                        state[selectedIndex].subCategoryId;
                    cubitEditProduct.testDropDown();
                  } else {
                    print("======  error in sub category");
                  }
                  //
                },
              );
            },
          ),
          // SizedBox(height: 10),
          // ===========================  for Brand  =======================
          BlocBuilder<GetBrandsByCategoryIdCubit, GetBrandsByCategoryIdState>(
            // listenWhen: (previous, current) {
            //   return previous is GetBrandsByCategoryIdInitial;
            // },
            // listener: (context, state) {
            //   context
            //       .read<GetBrandsByCategoryIdCubit>()
            //       .getBrandsByMainCategoryId(
            //           mainCategoryId: widget.initialMainIdToProduct);
            //   cubitEditProduct.selectedBrandId = widget.initialBrandIdToProduct;
            // },
            builder: (context, state) {
              if (state is GetBrandsByCategoryIdInitial) {
                return CustomDropdownWidget(
                  enabled: false,
                  textTitle: 'أختر اسم البراند',
                  hintText: "إختر الفئة الأساسية أولا",
                  initialItem: widget.initialBrandNameToProduct,
                  items: widget.initialBrandNameToProduct != null
                      ? [widget.initialBrandNameToProduct!]
                      : [],
                  onChanged: (value) => null,
                );
              }
              if (state is GetBrandsByCategoryIdLoading) {
                return CustomDropdownWidgetForStateCubit(
                    textTitle: 'أختر اسم البراند', hintText: "جاري التحميل...");
              }
              if (state is GetBrandsByCategoryIdSuccess) {
                final List<BrandEntity> brandsWithNoFound = [
                  BrandEntity(brandId: 000, brandNameEntity: "لا يوجد")
                ];
                final List<BrandEntity> brands = state.brands;
                brandsWithNoFound.addAll(brands);

                // set [selectedBrandId] auto first id duo [initialItem]
                // cubitAddProduct.selectedBrandId =
                //     brands.isNotEmpty ? brands.first.brandId : null;
                // for test
                cubitEditProduct.testDropDown();
                return CustomDropdownWidget(
                  enabled: true,
                  textTitle: 'أختر اسم البراند',
                  hintText: "قم بإختيار البراند المناسب",
                  initialItem: cubitEditProduct.isInitialDropDown
                      ? widget.initialBrandNameToProduct ??
                          brandsWithNoFound.first.brandNameEntity
                      : null,
                  items: brandsWithNoFound.length > 1
                      ? brandsWithNoFound
                          .map((category) => category.brandNameEntity)
                          .toList()
                      : [brandsWithNoFound.first.brandNameEntity],
                  // brands.isNotEmpty
                  //     ? brands
                  //         .map((category) => category.brandNameEntity)
                  //         .toList()
                  //     : [],
                  onChanged: (value) {
                    int selectedIndex = brandsWithNoFound.indexWhere(
                        (brandsWithNoFound) =>
                            brandsWithNoFound.brandNameEntity == value);

                    if (selectedIndex > 0) {
                      final int selectedBrandId =
                          brandsWithNoFound[selectedIndex].brandId;
                      //
                      cubitEditProduct.selectedBrandId = selectedBrandId;
                      // for test
                      // cubitEditProduct.testDropDown();
                    } else {
                      cubitEditProduct.selectedBrandId = null;
                      // for test
                      // cubitEditProduct.testDropDown();
                    }
                  },
                );
              }
              if (state is GetBrandsByCategoryIdFailure) {
                return CustomDropdownWidget(
                  enabled: false,
                  textTitle: 'أختر إسم البراند',
                  hintText: "فشل التحميل, أعد المحاولة",
                  items: [],
                  onChanged: (value) => null,
                  // initialItem: AddProductScreen._brandList[0],
                );
              }
              return CustomDropdownWidget(
                enabled: false,
                textTitle: 'أختر إسم البراند',
                hintText: "قم بإختيار البراند المناسب",
                items: [],
                onChanged: (value) => null,
                // initialItem: AddProductScreen._brandList[0],
              );
            },
          )
        ]),
      ),
    );
  }
}
