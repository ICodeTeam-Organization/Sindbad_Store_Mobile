// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_card_product_images_for_add_and_edit_product.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_card_product_info_for_edit_product.dart';
// import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/two_button_in_down_for_edit_product.dart';
// import '../../domain/entities/edit_product_entities/product_details_entity.dart';
// import '../../domain/entities/edit_product_entities/product_images_entity.dart';
// import '../manger/cubit/attribute_product/attribute_product_cubit.dart';
// import '../manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
// import 'custom_card_contains_all_drop_down_edit_screen.dart';
// import 'custom_card_to_all_attributes_fields.dart';

// class EditProductScreenBody extends StatefulWidget {
//   final ProductDetailsEntity productDetailsEntity;
//   final VoidCallback? onSuccessCallback;

//   const EditProductScreenBody({
//     super.key,
//     required this.productDetailsEntity,
//     this.onSuccessCallback,
//   });

//   @override
//   State<EditProductScreenBody> createState() => _EditProductScreenBodyState();
// }

// class _EditProductScreenBodyState extends State<EditProductScreenBody> {
//   late AttributeProductCubit cubitAttribute;
//   late EditProductFromStoreCubit cubitEditProduct;
//   late TextEditingController _priceProductController = TextEditingController();
//   late TextEditingController shortDescriptionProductController =
//       TextEditingController();
//   List<Map<String, dynamic>> productTags = [];
//   List<String> tags = [];
//   late TextEditingController oldPriceController = TextEditingController();
//   late TextEditingController _descriptionProductController =
//       TextEditingController();
//   late List<ProductImagesEntity> subImagesProduct;

//   // initialize attribute product from getProductDetails to cubit Attribute
//   void initializeAttribute() {
//     final List<String> textKeys = widget
//         .productDetailsEntity.attributesWithValuesProduct
//         .map((attribute) => attribute.attributeNameProduct)
//         .toList();
//     final List<String> textValues = widget
//         .productDetailsEntity.attributesWithValuesProduct
//         .map((attribute) => attribute.valueProduct)
//         .toList();
//     cubitAttribute.initialField(textKeys: textKeys, textValues: textValues);
//     tags = widget.productDetailsEntity.productTags
//             ?.map((tag) => tag['name'] as String)
//             .toList() ??
//         [];
//   }

//   @override
//   void initState() {
//     cubitAttribute = context.read<AttributeProductCubit>();
//     cubitEditProduct = context.read<EditProductFromStoreCubit>();

//     productTags = widget.productDetailsEntity.productTags ?? [];
//     shortDescriptionProductController.text =
//         widget.productDetailsEntity.productShortDescription ?? '';
//     oldPriceController.text =
//         widget.productDetailsEntity.productOldPrice?.toString() ?? '';
//     _priceProductController = TextEditingController(
//         text: widget.productDetailsEntity.priceProduct.toString());
//     _descriptionProductController = TextEditingController(
//         text: widget.productDetailsEntity.descriptionProduct.toString());
//     subImagesProduct = widget.productDetailsEntity.imagesProduct;

//     cubitEditProduct.saveBasicSubImages(
//         basicSubImages: widget.productDetailsEntity.imagesProduct
//             .map((image) => image.imageUrlProduct)
//             .toList());
//     initializeAttribute();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _priceProductController.dispose();
//     _descriptionProductController.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CustomAppBar(
//                 isSearch: false,
//                 tital: 'إضافة منتج',
//               ),
//               SizedBox(height: 40.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.0.w),
//                 child: Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // ==============  card Product Info  =============
//                       CustomCardProductInfoForEditProduct(
//                         productName: widget.productDetailsEntity.nameProduct,
//                         productNumber:
//                             widget.productDetailsEntity.numberProduct,
//                         priceProductController: _priceProductController,
//                         descriptionProductController:
//                             _descriptionProductController,
//                         shortDescriptionProductController:
//                             shortDescriptionProductController,
//                         oldPriceController: oldPriceController,
//                         tags: tags,
//                       ),
//                       SizedBox(height: 26.h),
//                       // ================  card Images  ===================
//                       CustomCardProductImagesForAddAndEditProduct(
//                         mainImageUrlProduct:
//                             widget.productDetailsEntity.mainImageUrlProduct,
//                         cubitEditProduct: cubitEditProduct,
//                         subImagesProduct: subImagesProduct,
//                       ),
//                       SizedBox(height: 26.h),
//                       // ================  card Drop down  ===================
//                       CustomCardContainsAllDropDownEditScreen(
//                         initialMainIdToProduct:
//                             widget.productDetailsEntity.mainCategoryIdProduct,
//                         initialSubIdToProduct: widget.productDetailsEntity
//                                 .subCategoryIdProduct.isEmpty
//                             ? null
//                             : widget
//                                 .productDetailsEntity.subCategoryIdProduct[0],
//                         initialBrandIdToProduct:
//                             widget.productDetailsEntity.brandIdProduct,
//                         initialMainNameToProduct:
//                             widget.productDetailsEntity.mainCategoryNameProduct,
//                         initialSubNameToProduct:
//                             widget.productDetailsEntity.subCategoriesName,
//                         initialBrandNameToProduct:
//                             widget.productDetailsEntity.brandNameProduct,
//                       ),
//                       SizedBox(height: 26.h),
//                       // ====================  Attribute card =============================
//                       CustomCardToAllAttributesFields(),
//                     ],
//                   ),
//                 ),
//               ),
//               // ==================== Two Button in Down  =============================
//               TwoButtonInDownForEditProduct(
//                 cubitEditProduct: cubitEditProduct,
//                 idProduct: widget.productDetailsEntity.idProduct,
//                 priceProductController: _priceProductController,
//                 descriptionProductController: _descriptionProductController,
//                 cubitAttribute: cubitAttribute,
//                 onSuccessCallback: widget.onSuccessCallback,
//                 oldPriceController: oldPriceController,
//                 shortDescriptionProductController:
//                     shortDescriptionProductController,
//                 tags: tags,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
