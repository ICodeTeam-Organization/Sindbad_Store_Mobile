import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/styles/Colors.dart';
import '../../../../../config/styles/text_style.dart';
import 'button_design_add_image_main_product_widget.dart';
import 'image_for_sub_images_widget.dart';

class DesignForUnselectedImageEditScreen extends StatelessWidget {
  final int boxNumber;
  final double containerWidth;
  final double upContainerHeight;
  final double downContainerHeight;
  final String titleButtonAddImage;

  const DesignForUnselectedImageEditScreen({
    super.key,
    required this.containerWidth,
    required this.upContainerHeight,
    required this.downContainerHeight,
    required this.titleButtonAddImage,
    required this.boxNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: containerWidth,
          height: upContainerHeight,
          child: DottedBorder(
            color: AppColors.primary,
            strokeWidth: 1.w,
            dashPattern: [16, 3],
            child: Container(
              width: containerWidth,
              height: upContainerHeight,
              decoration: BoxDecoration(
                color: AppColors.primaryOpacity,
                borderRadius: BorderRadius.circular(10.0.r),
              ),
              child: Center(
                child: boxNumber == 1
                    ? ButtonDesignAddImageMainProduct()
                    : ImageForSubImages(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: containerWidth,
          height: downContainerHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.redOpacity,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0.r),
                bottomRight: Radius.circular(10.0.r),
              ),
            ),
            child: Center(
              child: Text(
                titleButtonAddImage,
                style:
                    KTextStyle.textStyle14.copyWith(color: AppColors.greyDark),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
