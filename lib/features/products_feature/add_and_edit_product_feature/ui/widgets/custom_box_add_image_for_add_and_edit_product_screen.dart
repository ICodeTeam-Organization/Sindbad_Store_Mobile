import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import 'after_selected_image_for_add_and_edit_screen.dart';
import 'button_design_add_image_main_product_widget.dart';
import 'design_for_title_under_image_widget.dart';
import 'image_for_sub_images_widget.dart';

// ignore: must_be_immutable
class CustomBoxAddImageForAddAndEditProductScreen extends StatefulWidget {
  final int boxNumber;
  final String? initialImageUrl;
  final EditProductFromStoreCubit? cubitEditProduct;
  final AddProductToStoreCubit? cubitAddProduct;
  final double containerWidth;
  final double mainContainerHeight;
  final double upContainerHeight;
  final double downContainerHeight;
  final String actionButtonText;
  final String titleUnderBox;
  final ValueChanged<File?> onImageSelected; // Callback function

  const CustomBoxAddImageForAddAndEditProductScreen.CustomBoxAddImageForAddAndEditProductScreen({
    super.key,
    required this.boxNumber,
    required this.initialImageUrl,
    this.containerWidth = 85,
    this.mainContainerHeight = 117,
    this.upContainerHeight = 82,
    this.downContainerHeight = 35,
    this.actionButtonText = "إضافة صورة",
    this.titleUnderBox = "صورة المنتج",
    required this.onImageSelected,
    this.cubitEditProduct,
    this.cubitAddProduct,
  });

  @override
  State<CustomBoxAddImageForAddAndEditProductScreen> createState() =>
      _CustomBoxAddImageForAddAndEditProductScreenState();
}

class _CustomBoxAddImageForAddAndEditProductScreenState
    extends State<CustomBoxAddImageForAddAndEditProductScreen> {
  String? initialImageUrl;
  File? selectedImage;
  @override
  void initState() {
    initialImageUrl = widget.initialImageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              child: GestureDetector(
                onTap: () async {
                  final XFile? galleryImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (galleryImage != null) {
                    selectedImage = File(galleryImage.path);
                    initialImageUrl = null;
                    widget.onImageSelected(
                        selectedImage); // Return image to parent
                    setState(() {});
                  }
                },
                child: Container(
                  width: widget.containerWidth.w,
                  height: widget.upContainerHeight.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOpacity,
                    borderRadius: BorderRadius.circular(10.0.r),
                  ),
                  child: Center(
                    child: (selectedImage != null || initialImageUrl != null)
                        ? AfterSelectedImageForAddAndEditScreen(
                            boxNumber: widget.boxNumber,
                            initialImageUrl: initialImageUrl,
                            imageFile: selectedImage,
                            containerWidth: widget.containerWidth.w,
                            upContainerHeight: widget.upContainerHeight.h,
                            onTapDeleteImage: () {
                              selectedImage = null;
                              initialImageUrl = null;

                              setState(() {});

                              if (widget.cubitEditProduct != null) {
                                widget.cubitEditProduct!.deleteImageFromCubit(
                                    boxNum: widget.boxNumber);
                              }
                              if (widget.cubitAddProduct != null) {
                                widget.cubitAddProduct!.deleteImageFromCubit(
                                    boxNum: widget.boxNumber);
                              }
                            },
                          )
                        : widget.boxNumber == 1 // if == mainImage
                            ? const ButtonDesignAddImageMainProduct()
                            : const ImageForSubImages(),
                  ),
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
