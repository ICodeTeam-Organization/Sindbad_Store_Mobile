import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/add_images/add_image_to_product_add_cubit.dart';
import 'custom_add_image_widget.dart';

class CustomCardToAllImages extends StatelessWidget {
  final AddImageToProductAddCubit cubitAddImage;
  final AddProductToStoreCubit cubitAddProduct;

  const CustomCardToAllImages({
    super.key,
    required this.cubitAddImage,
    required this.cubitAddProduct,
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
            //  container Title
            SectionTitleWidget(title: "أختر صورة المنتح"),
            SizedBox(height: 20.h),
            // Add MAin image
            CustomAddImageWidget(
              imagePartNumber: 1,
              image: cubitAddImage.mainImageProduct,
              onTapPickImage: () async {
                await cubitAddImage.pickImageFromGallery(numPartImage: 1);
                cubitAddProduct.mainImageProductFile =
                    cubitAddImage.getImageFile(numBox: 1);
              },
              isForMainImage: true,
              containerWidth: 400.w,
              mainContainerHeight: 210.h,
              upContainerHeight: 175.h,
              downContainerHeight: 35.h,
              onPressed: () {},
            ),
            SizedBox(height: 25.h),
            // Add Sub images
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomAddImageWidget(
                  imagePartNumber: 2,
                  image: cubitAddImage.subOneImageProduct,
                  onTapPickImage: () async {
                    await cubitAddImage.pickImageFromGallery(numPartImage: 2);
                    cubitAddProduct.subOneImageProductFile =
                        cubitAddImage.getImageFile(numBox: 2);
                  },
                  onPressed: () {},
                ),
                CustomAddImageWidget(
                  imagePartNumber: 3,
                  image: cubitAddImage.subTwoImageProduct,
                  onTapPickImage: () async {
                    await cubitAddImage.pickImageFromGallery(numPartImage: 3);
                    cubitAddProduct.subTwoImageProductFile =
                        cubitAddImage.getImageFile(numBox: 3);
                  },
                  onPressed: () {},
                ),
                CustomAddImageWidget(
                  imagePartNumber: 4,
                  image: cubitAddImage.subThreeImageProduct,
                  onTapPickImage: () async {
                    await cubitAddImage.pickImageFromGallery(numPartImage: 4);
                    cubitAddProduct.subThreeImageProductFile =
                        cubitAddImage.getImageFile(numBox: 4);
                  },
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
