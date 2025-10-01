import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget_for_state_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/paginated_dropdown_list.dart';

class GetCategoryNamesSuccessWidget extends StatefulWidget {
  const GetCategoryNamesSuccessWidget({
    super.key,
    required this.mainAndSubCategories,
    required this.cubitCategories,
    required this.cubitAddProduct,
    this.scrollerController,
  });

  final List<CategoryEntity> mainAndSubCategories;
  final GetCategoryNamesCubit cubitCategories;
  final AddProductToStoreCubit cubitAddProduct;
  
  final ScrollController? scrollerController;

  @override
  State<GetCategoryNamesSuccessWidget> createState() =>
      _GetCategoryNamesSuccessWidgetState();
}

class _GetCategoryNamesSuccessWidgetState
    extends State<GetCategoryNamesSuccessWidget> {
      


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          PaginatedDropdownList(
            textTitle: 'أختر الفئة',
            hintText: "قم بإختيار الفئة المناسبة",
            itemParser: (item) => item.name ?? 'غير معروف',
            fetchItems: (int page, int pageSize) async {
              try {
                final cubit = context.read<GetCategoryNamesCubit>();
                
                final result = await cubit.getMainAndSubCategoryDirectly(
                  filterType: 1,
                  pageNumber: page,
                  pageSize: pageSize,
                );
                
                if (result.isRight()) {
                  final categories = result.getOrElse(() => []);
                  print('Loaded ${categories.length} categories');
                  return categories;
                } else {
                  final failure = result.fold((f) => f, (r) => null);
                  print('Error: ${failure?.message}');
                  return [];
                }
              } catch (e) {
                print('Exception: $e');
                return [];
              }
            },
            pageSize: 10,

             onChanged: (value) {
               final cubit = context.read<AddProductToStoreCubit>();
               cubit.changeMainCategoryId(2);
            // int selectedIndex = widget.mainAndSubCategories
            //     .indexWhere((category) => category.categoryName == value);
            // if (selectedIndex != -1) {
            //   final int selectedMainCategoryId =
            //       widget.mainAndSubCategories[selectedIndex].categoryId;

            //   widget.cubitCategories.updateSubCategories(
            //       selectedMainCategoryId); // refresh sub categories
            //   context
            //       .read<GetBrandsByCategoryIdCubit>()
            //       .getBrandsByMainCategoryId(
            //           mainCategoryId: selectedMainCategoryId);
             // widget.cubitAddProduct.selectedMainCategoryId=2;
               // widget.cubitAddProduct.selectedMainCategoryId =
               // widget.mainAndSubCategories[selectedIndex].categoryId;

              //  widget.cubitAddProduct.selectedSubCategoryId = null;
              //  widget.cubitAddProduct.selectedBrandId = null;
              
            
          },
          ),
        // =================  Main Category ================
    //    CustomDropdownWidget(
    //       enabled: true,
    //       textTitle: 'أختر الفئة',
    //       hintText: "قم بإختيار الفئة المناسبة",
    //       initialItem: widget.cubitAddProduct.selectedMainCategoryId != null
    // ? widget.mainAndSubCategories
    //     .firstWhere(
    //       (c) => c.categoryId == widget.cubitAddProduct.selectedMainCategoryId,
    //       orElse: () => widget.mainAndSubCategories.first,
    //     )
    //     .categoryName
    // : null,
    //       scrollController: widget.scrollerController,
    //       items: widget.mainAndSubCategories.isNotEmpty
    //           ? widget.mainAndSubCategories
    //               .map((category) => category.categoryName)
    //               .toList()
    //           : [],
    //       onChanged: (value) {
    //         int selectedIndex = widget.mainAndSubCategories
    //             .indexWhere((category) => category.categoryName == value);
    //         if (selectedIndex != -1) {
    //           final int selectedMainCategoryId =
    //               widget.mainAndSubCategories[selectedIndex].categoryId;

    //           widget.cubitCategories.updateSubCategories(
    //               selectedMainCategoryId); // refresh sub categories
    //           context
    //               .read<GetBrandsByCategoryIdCubit>()
    //               .getBrandsByMainCategoryId(
    //                   mainCategoryId: selectedMainCategoryId);

    //           setState(() {
    //             widget.cubitAddProduct.selectedMainCategoryId =
    //                 widget.mainAndSubCategories[selectedIndex].categoryId;

    //             widget.cubitAddProduct.selectedSubCategoryId = null;
    //             widget.cubitAddProduct.selectedBrandId = null;
    //           });
    //         }
    //       },
    //     ),
         SizedBox(height: 10),

    //     // =================  Sub Category ================
        BlocBuilder<AddProductToStoreCubit, AddProductToStoreState>(
  builder: (context, state) {
    return  CustomDropdownWidget(
              enabled:state is ChangeMainCategoryIdState ? state.seleted : false,
              textTitle: 'أختر القسم',
              hintText: "إختر الفئة الأساسية أولا",
              initialItem: widget.cubitCategories.subCategories.isNotEmpty
                  ? widget.cubitCategories.subCategories.first.categoryName
                  : null,
              items: widget.cubitCategories.subCategories.isNotEmpty
                  ? widget.cubitCategories.subCategories
                      .map((subCategory) => subCategory.categoryName)
                      .toList()
                  : [],
              onChanged: (value) {
                widget.cubitAddProduct.selectedSubCategoryId = widget
                    .cubitCategories.subCategories
                    .firstWhere(
                        (subCategories) => subCategories.categoryName == value)
                    .categoryId;
              },
            );
          }
        ),
        SizedBox(height: 10),
        // ===========================  for Brand  =======================
        BlocBuilder<GetBrandsByCategoryIdCubit, GetBrandsByCategoryIdState>(
          builder: (context, state) {
            if (state is GetBrandsByCategoryIdInitial) {
              return CustomDropdownWidgetForStateCubit(
                  textTitle: 'أختر اسم البراند',
                  isRequired: false,
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
                isRequired: false,
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
                    widget.cubitAddProduct.selectedBrandId =
                        brandsWithNoFound[selectedIndex].brandId;
                  } else {
                    widget.cubitAddProduct.selectedBrandId = null;
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
