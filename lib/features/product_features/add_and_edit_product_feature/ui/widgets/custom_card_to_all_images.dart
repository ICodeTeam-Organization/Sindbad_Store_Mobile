import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../../../../../core/styles/text_style.dart';
import '../manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'custom_add_image_widget.dart';

class CustomCardToAllImages extends StatelessWidget {
  const CustomCardToAllImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddImageToProductAddCubit cubitAddImage =
        context.read<AddImageToProductAddCubit>();
    final AddProductToStoreCubit cubitAddProduct =
        context.read<AddProductToStoreCubit>();

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
                    cubitAddImage.getIamgeFile(numBox: 1);
                print("image path main = ${cubitAddProduct.mainImageProduct}");
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
                        cubitAddImage.getIamgeFile(numBox: 2);
                    print(
                        "image path sub 1 = ${cubitAddProduct.subOneImageProduct}");
                  },
                  onPressed: () {},
                ),
                CustomAddImageWidget(
                  imagePartNumber: 3,
                  image: cubitAddImage.subTwoImageProduct,
                  onTapPickImage: () async {
                    await cubitAddImage.pickImageFromGallery(numPartImage: 3);
                    cubitAddProduct.subTwoImageProductFile =
                        cubitAddImage.getIamgeFile(numBox: 3);
                    print(
                        "image path sub 2 = ${cubitAddProduct.subTwoImageProduct}");
                  },
                  onPressed: () {},
                ),
                CustomAddImageWidget(
                  imagePartNumber: 4,
                  image: cubitAddImage.subThreeImageProduct,
                  onTapPickImage: () async {
                    await cubitAddImage.pickImageFromGallery(numPartImage: 4);
                    cubitAddProduct.subThreeImageProductFile =
                        cubitAddImage.getIamgeFile(numBox: 4);
                    print(
                        "image path sub 3 = ${cubitAddProduct.subThreeImageProduct}");
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
