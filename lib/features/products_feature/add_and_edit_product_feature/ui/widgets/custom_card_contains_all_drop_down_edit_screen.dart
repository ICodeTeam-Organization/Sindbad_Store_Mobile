// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/config/styles/Colors.dart';
// import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/brand_entity.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget_for_state_cubit.dart';

// class CustomCardContainsAllDropDownEditScreen extends StatefulWidget {
//   final int initialMainIdToProduct;
//   int? initialSubIdToProduct;
//   final int? initialBrandIdToProduct;
//   final String initialMainNameToProduct;
//   String initialSubNameToProduct;
//   final String? initialBrandNameToProduct;
//   CustomCardContainsAllDropDownEditScreen({
//     super.key,
//     required this.initialMainIdToProduct,
//     required this.initialSubIdToProduct,
//     required this.initialBrandIdToProduct,
//     required this.initialMainNameToProduct,
//     required this.initialSubNameToProduct,
//     required this.initialBrandNameToProduct,
//   });

//   @override
//   State<CustomCardContainsAllDropDownEditScreen> createState() =>
//       _CustomCardContainsAllDropDownEditScreenState();
// }

// class _CustomCardContainsAllDropDownEditScreenState
//     extends State<CustomCardContainsAllDropDownEditScreen> {
//   late final cubitCategories = context.read<GetCategoryNamesCubit>();
//   late final cubitEditProduct = context.read<EditProductFromStoreCubit>();
//   List<CategoryEntity> subCategories = [];
//   late ScrollController scrollController;

//   @override
//   void initState() {
//     super.initState();
//     // FIX: Initialize scroll controller FIRST
//     scrollController = ScrollController();
//     context.read<GetCategoryNamesCubit>().getMainAndSubCategory();
//     context.read<GetBrandsByCategoryIdCubit>().getBrandsByMainCategoryId(
//         mainCategoryId: widget.initialMainIdToProduct);

//     scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     print('=== SCROLL DEBUG INFO ===');
//     // if(isLodingMore){
//     if (scrollController.position.pixels ==
//         scrollController.position.maxScrollExtent) {
//       context.read<GetCategoryNamesCubit>().getMainAndSubCategory();
//       // }
//     }
//   }

//   List<CategoryEntity> categoryAndSubCategoryNames = [];
//   int pageNumber = 1;
//   bool isLodingMore = true;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       decoration: BoxDecoration(
//           color: AppColors.white,
//           border: Border.all(color: AppColors.greyBorder),
//           borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           // container Title
//           SectionTitleWidget(title: 'نوع المنتج'),
//           SizedBox(height: 20.h),
//           // =======================   Main Category  ========================
//           BlocConsumer<GetCategoryNamesCubit, GetCategoryNamesState>(
//             listener: (context, state) {
//               if (state is GetCategoryNamesSuccess) {
//                 if (state.categoryAndSubCategoryNames.length > 10) {
//                   isLodingMore = false;
//                 }
//                 categoryAndSubCategoryNames
//                     .addAll(state.categoryAndSubCategoryNames);
//               }
//             },
//             builder: (context, state) {
//               if (state is GetCategoryNamesInitial) {
//                 return CustomDropdownWidget(
//                   textTitle: 'أختر الفئة',
//                   hintText: "قم بإختيار الفئة المناسبة",
//                   items: [],
//                   initialItem: widget.initialMainNameToProduct,
//                   onChanged: (value) {},
//                 );
//               }

//               if (state is GetCategoryNamesSuccess) {
//                 return CustomDropdownWidget(
//                     initialItem: cubitEditProduct.isInitialDropDown
//                         ? widget.initialMainNameToProduct
//                         : null,
//                     scrollController: scrollController,
//                     textTitle: 'أختر الفئة',
//                     hintText: "قم بإختيار الفئة المناسبة",
//                     items: categoryAndSubCategoryNames
//                         .map((category) => category.categoryName)
//                         .toList(),
//                     onChanged: (value) {
//                       int selectedIndex =
//                           categoryAndSubCategoryNames.indexWhere(
//                               (category) => category.categoryName == value);
//                       if (selectedIndex != -1) {
//                         widget.initialSubIdToProduct =
//                             categoryAndSubCategoryNames[selectedIndex]
//                                 .categoryId;
//                         widget.initialSubNameToProduct =
//                             categoryAndSubCategoryNames[selectedIndex]
//                                 .categoryName;
//                         context
//                             .read<GetBrandsByCategoryIdCubit>()
//                             .getBrandsByMainCategoryId(
//                                 mainCategoryId:
//                                     categoryAndSubCategoryNames[selectedIndex]
//                                         .categoryId);
//                         context
//                             .read<GetBrandsByCategoryIdCubit>()
//                             .getBrandsByMainCategoryId(
//                                 mainCategoryId: widget.initialMainIdToProduct);
//                         subCategories = context
//                             .watch<GetCategoryNamesCubit>()
//                             .subCategories;
//                       }
//                     });
//               }
//               return CustomDropdownWidget(
//                 enabled: false,
//                 textTitle: 'أختر الفئة',
//                 hintText: "قم بإختيار الفئة المناسبة",
//                 items: ["الافتراضي"],
//                 initialItem: null,
//                 onChanged: (value) {},
//               );
//             },
//           ),
//           SizedBox(height: 10.h),

//           // =======================   Sub Category  ========================
//           CustomDropdownWidget(
//             enabled: widget.initialMainIdToProduct != 0,
//             textTitle: 'أختر القسم',
//             hintText: "قم بإختيار الفئة الفرعية المناسبة",
//             items: subCategories.isNotEmpty
//                 ? subCategories
//                     .map((subCategory) => subCategory.categoryName)
//                     .toList()
//                 : [widget.initialSubNameToProduct],
//             onChanged: (value) {
//               // [get] Index by mainCatNameSelected from list mainAndSubCategories

//               // [get] Id_Category by selectedIndex from list mainAndSubCategories

//               cubitEditProduct.selectedSubCategoryId = subCategories
//                   .where((subCategory) => subCategory.categoryName == value)
//                   .first
//                   .categoryId;

//               //
//             },
//           ),

//           SizedBox(height: 10.h),
//           // ===========================  for Brand  =======================
//           BlocBuilder<GetBrandsByCategoryIdCubit, GetBrandsByCategoryIdState>(
//             // listenWhen: (previous, current) {
//             //   return previous is GetBrandsByCategoryIdInitial;
//             // },
//             // listener: (context, state) {
//             //   context
//             //       .read<GetBrandsByCategoryIdCubit>()
//             //       .getBrandsByMainCategoryId(
//             //           mainCategoryId: widget.initialMainIdToProduct);
//             //   cubitEditProduct.selectedBrandId = widget.initialBrandIdToProduct;
//             // },
//             builder: (context, state) {
//               if (state is GetBrandsByCategoryIdInitial) {
//                 return CustomDropdownWidget(
//                   enabled: false,
//                   textTitle: 'أختر اسم البراند',
//                   hintText: "إختر الفئة الأساسية أولا",
//                   initialItem: widget.initialBrandNameToProduct,
//                   items: widget.initialBrandNameToProduct != null
//                       ? [widget.initialBrandNameToProduct!]
//                       : [],
//                   onChanged: (value) => null,
//                 );
//               }
//               if (state is GetBrandsByCategoryIdLoading) {
//                 return CustomDropdownWidgetForStateCubit(
//                     textTitle: 'أختر اسم البراند', hintText: "جاري التحميل...");
//               }
//               if (state is GetBrandsByCategoryIdSuccess) {
//                 final List<BrandEntity> brandsWithNoFound = [
//                   BrandEntity(brandId: 000, brandNameEntity: "لا يوجد")
//                 ];
//                 final List<BrandEntity> brands = state.brands;
//                 brandsWithNoFound.addAll(brands);

//                 return CustomDropdownWidget(
//                   enabled: true,
//                   textTitle: 'أختر اسم البراند',
//                   hintText: "قم بإختيار البراند المناسب",
//                   initialItem: cubitEditProduct.isInitialDropDown
//                       ? widget.initialBrandNameToProduct ??
//                           brandsWithNoFound.first.brandNameEntity
//                       : null,
//                   items: brandsWithNoFound.length > 1
//                       ? brandsWithNoFound
//                           .map((category) => category.brandNameEntity)
//                           .toList()
//                       : [brandsWithNoFound.first.brandNameEntity],
//                   // brands.isNotEmpty
//                   //     ? brands
//                   //         .map((category) => category.brandNameEntity)
//                   //         .toList()
//                   //     : [],
//                   onChanged: (value) {
//                     int selectedIndex = brandsWithNoFound.indexWhere(
//                         (brandsWithNoFound) =>
//                             brandsWithNoFound.brandNameEntity == value);

//                     if (selectedIndex > 0) {
//                       final int selectedBrandId =
//                           brandsWithNoFound[selectedIndex].brandId;
//                       //
//                       cubitEditProduct.selectedBrandId = selectedBrandId;
//                       // for test
//                       // cubitEditProduct.testDropDown();
//                     } else {
//                       // if user select "لا يوجد"
//                       cubitEditProduct.selectedBrandId = 000;
//                       // for test
//                       // cubitEditProduct.testDropDown();
//                     }
//                   },
//                 );
//               }
//               if (state is GetBrandsByCategoryIdFailure) {
//                 return CustomDropdownWidget(
//                   enabled: false,
//                   textTitle: 'أختر إسم البراند',
//                   hintText: "فشل التحميل, أعد المحاولة",
//                   items: [],
//                   onChanged: (value) => null,
//                   // initialItem: AddProductScreen._brandList[0],
//                 );
//               }
//               return CustomDropdownWidget(
//                 enabled: false,
//                 textTitle: 'أختر إسم البراند',
//                 hintText: "قم بإختيار البراند المناسب",
//                 items: [],
//                 onChanged: (value) => null,
//                 // initialItem: AddProductScreen._brandList[0],
//               );
//             },
//           )
//         ]),
//       ),
//     );
//   }
// }
