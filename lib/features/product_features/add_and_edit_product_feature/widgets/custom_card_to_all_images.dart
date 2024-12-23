import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../../../../core/styles/text_style.dart';
import '../ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
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

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      color: Colors.white,
      child: Container(
        width: 363.0.w,
        height: 434.0.h,
        margin: EdgeInsets.only(
          bottom: 20.0.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  container Title
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 16.0.h, top: 8.h, right: 20.0.w),
                child: Text(
                  "أختر صورة المنتح",
                  style: KTextStyle.textStyle16
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
              containerWidth: 333.w,
              mainContainerHeight: 210.h,
              upContainerHeight: 175.h,
              downContainerHeight: 35.h,
              onPressed: () {},
            ),
            SizedBox(
              height: 25.0.h,
            ),

            // Add Sub images
            Padding(
              padding: EdgeInsets.only(
                left: 14.w,
                // right: 8.w
              ),
              child: Row(
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
                  SizedBox(
                    width: 15.0.w,
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
                  SizedBox(
                    width: 15.0.w,
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
            ),
          ],
        ),
      ),
    );
  }
}
