import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_card_product_attribute_for_edit_product.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_card_product_images_for_edit_product.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_card_product_info_for_edit_product.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/two_button_in_down_for_edit_product.dart';
import '../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../../domain/entities/edit_product_entities/product_images_entity.dart';
import '../manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import '../manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import 'custom_card_contains_all_drop_down_edit_screen.dart';

class EditProductScreenBody extends StatefulWidget {
  final ProductDetailsEntity productDetailsEntity;

  const EditProductScreenBody({
    super.key,
    required this.productDetailsEntity,
  });

  @override
  State<EditProductScreenBody> createState() => _EditProductScreenBodyState();
}

class _EditProductScreenBodyState extends State<EditProductScreenBody> {
  late AddAttributeProductDartCubit cubitAttribute;
  late EditProductFromStoreCubit cubitEditProduct;
  late TextEditingController _priceProductController = TextEditingController();
  late TextEditingController _descriptionProductController =
      TextEditingController();
  late List<ProductImagesEntity> subImagesProduct;

  @override
  void initState() {
    cubitAttribute = context.read<AddAttributeProductDartCubit>();
    cubitEditProduct = context.read<EditProductFromStoreCubit>();

    _priceProductController = TextEditingController(
        text: widget.productDetailsEntity.priceProduct.toString());
    _descriptionProductController = TextEditingController(
        text: widget.productDetailsEntity.descriptionProduct.toString());
    subImagesProduct = widget.productDetailsEntity.imagesProduct;

    cubitEditProduct.saveBasicSubImages(
        basicSubImages: widget.productDetailsEntity.imagesProduct
            .map((image) => image.imageUrlProduct)
            .toList());
    // loop to add attribute product from getProductDetails to cubit Attribute
    for (var attribute
        in widget.productDetailsEntity.attributesWithValuesProduct) {
      cubitAttribute.keys
          .add(TextEditingController(text: attribute.attributeNameProduct));
      cubitAttribute.values.add(
        TextEditingController(
            text: attribute.valueProduct.isNotEmpty
                ? attribute.valueProduct.first
                : ""),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    _priceProductController.dispose();
    _descriptionProductController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      // ==============  card Product Info  =============
                      CustomCardProductInfoForEditProduct(
                        productName: widget.productDetailsEntity.nameProduct,
                        productNumber:
                            widget.productDetailsEntity.numberProduct,
                        priceProductController: _priceProductController,
                        descriptionProductController:
                            _descriptionProductController,
                      ),
                      SizedBox(height: 26.h),
                      // ================  card Images  ===================
                      CustomCardProductImagesForEditProduct(
                        mainImageUrlProduct:
                            widget.productDetailsEntity.mainImageUrlProduct,
                        cubitEditProduct: cubitEditProduct,
                        subImagesProduct: subImagesProduct,
                      ),
                      SizedBox(height: 26.h),
                      // ================  card Drop down  ===================
                      CustomCardContainsAllDropDownEditScreen(
                        initialMainIdToProduct:
                            widget.productDetailsEntity.mainCategoryIdProduct,
                        initialSubIdToProduct:
                            widget.productDetailsEntity.subCategoryIdProduct[0],
                        initialBrandIdToProduct:
                            widget.productDetailsEntity.brandIdProduct,
                        initialMainNameToProduct:
                            widget.productDetailsEntity.mainCategoryNameProduct,
                        initialSubNameToProduct:
                            widget.productDetailsEntity.subCategoriesName,
                        initialBrandNameToProduct:
                            widget.productDetailsEntity.brandNameProduct,
                      ),
                      SizedBox(height: 26.h),
                      // ====================  Attribute card =============================
                      CustomCardProductAttributeForEditProduct(
                          cubitAttribute: cubitAttribute),
                    ],
                  ),
                ),
              ),
              // ==================== Two Button in Down  =============================
              TwoButtonInDownForEditProduct(
                cubitEditProduct: cubitEditProduct,
                idProduct: widget.productDetailsEntity.idProduct,
                priceProductController: _priceProductController,
                descriptionProductController: _descriptionProductController,
                cubitAttribute: cubitAttribute,
              )
            ],
          ),
        ),
      ),
    );
  }
}
