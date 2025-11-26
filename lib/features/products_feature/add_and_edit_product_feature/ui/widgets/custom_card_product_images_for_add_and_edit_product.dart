import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/edit_product_entities/product_images_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_box_add_image_for_add_and_edit_product_screen.dart';

import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';

class CustomCardProductImagesForAddAndEditProduct extends StatelessWidget {
  const CustomCardProductImagesForAddAndEditProduct({
    super.key,
    required this.mainImageUrlProduct,
    this.cubitEditProduct,
    required this.subImagesProduct,
    this.cubitAddProduct,
  });

  final String? mainImageUrlProduct;
  final EditProductFromStoreCubit? cubitEditProduct;
  final AddProductToStoreCubit? cubitAddProduct;
  final List<ProductImagesEntity>
      subImagesProduct; // for edit product .... if in add product => []

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
            //  container Title
            SectionTitleWidget(title: "أختر صورة المنتح"),
            SizedBox(height: 20.h),
            // ========  for Main Image  =======
            CustomBoxAddImageForAddAndEditProductScreen
                .CustomBoxAddImageForAddAndEditProductScreen(
              cubitAddProduct: cubitAddProduct,
              cubitEditProduct: cubitEditProduct,
              initialImageUrl: mainImageUrlProduct,
              boxNumber: 1,
              containerWidth: 400.w,
              mainContainerHeight: 210.h,
              upContainerHeight: 175.h,
              downContainerHeight: 35.h,
              onImageSelected: (value) {
                if (cubitEditProduct != null) {
                  cubitEditProduct!.saveImageInCubit(
                      boxNum: 1, file: value); // for edit page
                }
                if (cubitAddProduct != null) {
                  cubitAddProduct!
                      .saveImageInCubit(boxNum: 1, file: value); // for add page
                }
              },
            ),
            SizedBox(height: 25.h),
            // ========  for 3 Sub Images  =======
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBoxAddImageForAddAndEditProductScreen
                    .CustomBoxAddImageForAddAndEditProductScreen(
                  cubitAddProduct: cubitAddProduct,
                  cubitEditProduct: cubitEditProduct,
                  boxNumber: 2,
                  initialImageUrl: subImagesProduct.isNotEmpty
                      ? subImagesProduct[0].imageUrlProduct
                      : null,
                  onImageSelected: (value) {
                    if (cubitEditProduct != null) {
                      cubitEditProduct!.saveImageInCubit(
                          boxNum: 2, file: value); // for edit page
                    }
                    if (cubitAddProduct != null) {
                      cubitAddProduct!.saveImageInCubit(
                          boxNum: 2, file: value); // for add page
                    }
                  },
                ),
                CustomBoxAddImageForAddAndEditProductScreen
                    .CustomBoxAddImageForAddAndEditProductScreen(
                  cubitAddProduct: cubitAddProduct,
                  cubitEditProduct: cubitEditProduct,
                  boxNumber: 3,
                  initialImageUrl: subImagesProduct.length > 1
                      ? subImagesProduct[1].imageUrlProduct
                      : null,
                  onImageSelected: (value) {
                    if (cubitEditProduct != null) {
                      cubitEditProduct!.saveImageInCubit(
                          boxNum: 3, file: value); // for edit page
                    }
                    if (cubitAddProduct != null) {
                      cubitAddProduct!.saveImageInCubit(
                          boxNum: 3, file: value); // for add page
                    }
                  },
                ),
                CustomBoxAddImageForAddAndEditProductScreen
                    .CustomBoxAddImageForAddAndEditProductScreen(
                  cubitAddProduct: cubitAddProduct,
                  cubitEditProduct: cubitEditProduct,
                  boxNumber: 4,
                  initialImageUrl: subImagesProduct.length > 2
                      ? subImagesProduct[2].imageUrlProduct
                      : null,
                  onImageSelected: (value) {
                    if (cubitEditProduct != null) {
                      cubitEditProduct!.saveImageInCubit(
                          boxNum: 4, file: value); // for edit page
                    }
                    if (cubitAddProduct != null) {
                      cubitAddProduct!.saveImageInCubit(
                          boxNum: 4, file: value); // for add page
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
