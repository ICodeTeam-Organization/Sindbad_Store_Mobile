import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'aa.dart';
import 'after_selected_image_widget.dart';
import 'button_design_add_image_main_product_widget.dart';
import 'design_for_title_under_image_widget.dart';
import 'design_for_unselected_image_widget.dart';
import 'image_for_sub_images_widget.dart';

// ignore: must_be_immutable
class CustomBoxAddImageForEditProductScreen extends StatefulWidget {
  final int boxNumber;
  final String? initialImageUrl;
  final double containerWidth;
  final double mainContainerHeight;
  final double upContainerHeight;
  final double downContainerHeight;
  final String actionButtonText;
  final String titleUnderBox;
  // final VoidCallback onPressed;
  // final Future<void> Function() onTapPickImage;
  // final bool isForMainImage;
  // File? image;
  // int? imagePartNumber; // لتحديد الصورة المناسبة لكل مربع
  // String? initialImageUrl; // Add initial image URL

  const CustomBoxAddImageForEditProductScreen({
    super.key,
    required this.boxNumber,
    required this.initialImageUrl,
    this.containerWidth = 100.46,
    this.mainContainerHeight = 117,
    this.upContainerHeight = 82,
    this.downContainerHeight = 35,
    this.actionButtonText = "إضافة صورة",
    this.titleUnderBox = "صورة المنتج",
    // required this.onPressed,
    // this.isForMainImage = false,
    // this.initialImageUrl,
    // this.imagePartNumber,
    // required this.onTapPickImage,
    // this.image, // Add initial image URL
  });

  @override
  State<CustomBoxAddImageForEditProductScreen> createState() =>
      _CustomBoxAddImageForEditProductScreenState();
}

class _CustomBoxAddImageForEditProductScreenState
    extends State<CustomBoxAddImageForEditProductScreen> {
  String? initialImageUrl;
  File? selectedImage;
  @override
  void initState() {
    initialImageUrl = widget.initialImageUrl;
    debugPrint(
        "================  initialImageUrl ===  $initialImageUrl  =============");
    // setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "================  initialImageUrl ===  $initialImageUrl  =============");
    return SizedBox(
      width: widget.containerWidth.w,
      height: widget.mainContainerHeight.h,
      child: Column(
        children: [
          SizedBox(
            width: widget.containerWidth.w,
            height: widget.upContainerHeight.h,
            child: DottedBorder(
              color: AppColors.primary,
              strokeWidth: 1.w,
              dashPattern: [16, 3],
              child: Container(
                width: widget.containerWidth.w,
                height: widget.upContainerHeight.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryOpacity,
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
                child: Center(
                  child: GestureDetector(
                      onTap: () async {
                        final XFile? galleryImage = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (galleryImage != null) {
                          selectedImage = File(galleryImage.path);
                          initialImageUrl = null;
                          setState(() {});
                        }
                      },
                      child: (selectedImage != null || initialImageUrl != null)
                          ? AfterSelectedImageForEditScreen(
                              boxNumber: widget.boxNumber,
                              initialImageUrl: initialImageUrl,
                              imageFile: selectedImage,
                              containerWidth: widget.containerWidth.w,
                              upContainerHeight: widget.upContainerHeight.h,
                              onTapDeleteImage: () {
                                selectedImage = null;
                                initialImageUrl = null;
                                setState(() {});
                              },
                            )
                          : widget.boxNumber == 1 // if == mainImage
                              ? const ButtonDesignAddImageMainProduct()
                              : const ImageForSubImages()),
                ),
              ),
            ),
          ),
          DesignForTitleUnderImage(
              title: widget.titleUnderBox,
              width: widget.containerWidth.w,
              height: widget.downContainerHeight.h),
        ],
      ),
    );
  }
}
          // في حال اول مره فتح الصفحة - لم يختار أي صورة بعد
// DesignForUnselectedImage(
//             isForMainImage: isForMainImage,
//             titleText: titleText,
//             containerWidth: containerWidth.w,
//             upContainerHeight: upContainerHeight.h,
//             downContainerHeight: downContainerHeight.h,
//             onTapPickImage: onTapPickImage,
//           )