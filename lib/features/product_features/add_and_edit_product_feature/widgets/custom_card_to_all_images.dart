import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/text_style.dart';
import '../ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'custom_add_image_widget.dart';

class CustomCardToAllImages extends StatelessWidget {
  const CustomCardToAllImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              image: context.read<AddImageToProductAddCubit>().mainImageProduct,
              onTapPickImage: () => context
                  .read<AddImageToProductAddCubit>()
                  .pickImageFromGallery(numPartImage: 1),
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
                    image: context
                        .read<AddImageToProductAddCubit>()
                        .subOneImageProduct,
                    onTapPickImage: () => context
                        .read<AddImageToProductAddCubit>()
                        .pickImageFromGallery(numPartImage: 2),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 15.0.w,
                  ),
                  CustomAddImageWidget(
                    imagePartNumber: 3,
                    image: context
                        .read<AddImageToProductAddCubit>()
                        .subTwoImageProduct,
                    onTapPickImage: () => context
                        .read<AddImageToProductAddCubit>()
                        .pickImageFromGallery(numPartImage: 3),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 15.0.w,
                  ),
                  CustomAddImageWidget(
                    imagePartNumber: 4,
                    image: context
                        .read<AddImageToProductAddCubit>()
                        .subThreeImageProduct,
                    onTapPickImage: () => context
                        .read<AddImageToProductAddCubit>()
                        .pickImageFromGallery(numPartImage: 4),
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
