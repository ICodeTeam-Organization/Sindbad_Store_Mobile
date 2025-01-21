import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'after_selected_image_widget.dart';
import 'button_design_add_image_main_product_widget.dart';
import 'design_for_title_under_image_widget.dart';
import 'design_for_unselected_image_widget.dart';
import 'image_for_sub_images_widget.dart';

// ignore: must_be_immutable
class CustomAddImageWidget extends StatelessWidget {
  final double containerWidth;
  final double mainContainerHeight;
  final double upContainerHeight;
  final double downContainerHeight;
  final String actionButtonText;
  final String titleText;
  final VoidCallback onPressed;
  final Future<void> Function() onTapPickImage;
  final bool isForMainImage;
  File? image;
  int? imagePartNumber; // لتحديد الصورة المناسبة لكل مربع
  String? initialImageUrl; // Add initial image URL

  CustomAddImageWidget(
      {super.key,
      this.containerWidth = 85,
      this.mainContainerHeight = 117,
      this.upContainerHeight = 82,
      this.downContainerHeight = 35,
      this.actionButtonText = "إضافة صورة",
      this.titleText = "صورة المنتج",
      required this.onPressed,
      this.isForMainImage = false,
      this.initialImageUrl,
      this.imagePartNumber,
      required this.onTapPickImage,
      this.image // Add initial image URL
      });

  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerWidth.w,
      height: mainContainerHeight.h,
      child: BlocBuilder<AddImageToProductAddCubit, AddImageToProductAddState>(
        builder: (context, state) {
          if (state is AddImageToProductAddSuccess) {
            final AddImageToProductAddCubit cubitAddImage =
                context.read<AddImageToProductAddCubit>();

            return Column(
              children: [
                SizedBox(
                  width: containerWidth.w,
                  height: upContainerHeight.h,
                  child: DottedBorder(
                    color: AppColors.primary,
                    strokeWidth: 1.w,
                    dashPattern: [16, 3],
                    child: Container(
                      width: containerWidth.w,
                      height: upContainerHeight.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryOpacity,
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      child: Center(
                        child: GestureDetector(
                            onTap: onTapPickImage,
                            child: cubitAddImage.imageByNumBox(
                                        numBox: imagePartNumber!) !=
                                    null
                                ? AfterSelectedImage(
                                    boxNumber: imagePartNumber!,
                                    imageFile: cubitAddImage.imageByNumBox(
                                        numBox: imagePartNumber!)!,
                                    containerWidth: containerWidth.w,
                                    upContainerHeight: upContainerHeight.h,
                                  )
                                : isForMainImage
                                    ? ButtonDesignAddImageMainProduct()
                                    : ImageForSubImages()),
                      ),
                    ),
                  ),
                ),
                DesignForTitleUnderImage(
                    title: titleText,
                    width: containerWidth.w,
                    height: downContainerHeight.h),
              ],
            );
          }
          // في حال اول مره فتح الصفحة - لم يختار أي صورة بعد
          return DesignForUnselectedImage(
            isForMainImage: isForMainImage,
            titleText: titleText,
            containerWidth: containerWidth.w,
            upContainerHeight: upContainerHeight.h,
            downContainerHeight: downContainerHeight.h,
            onTapPickImage: onTapPickImage,
          );
        },
      ),
    );
  }
}
