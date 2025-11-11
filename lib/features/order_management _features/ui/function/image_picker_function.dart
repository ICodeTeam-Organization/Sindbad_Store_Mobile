import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/swidgets/new_widgets/store_primary_button.dart';
import '../../../../config/styles/Colors.dart';

File? images;

class ImagePickerFunction extends StatefulWidget {
  const ImagePickerFunction({super.key});

  @override
  State<ImagePickerFunction> createState() => _ImagePickerFunctionState();
}

class _ImagePickerFunctionState extends State<ImagePickerFunction> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Color(0x1AFF746B),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: DottedBorder(
                color: AppColors.redColor,
                radius: Radius.circular(16.r),
                strokeWidth: 1,
                dashPattern: [5, 10],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 207.h,
                      width: 295.w,
                      child: selectedImage != null
                          ? SizedBox(
                              height: 207.h,
                              width: 295,
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.fill,
                              ),
                            )
                          : const Text(" "),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StorePrimaryButton(
                  onTap: () => pickImageFromCamera(),
                  icon: Icons.camera_alt,
                  title: "الكاميرا",
                  width: 90.w,
                ),
                SizedBox(
                  width: 7.h,
                ),
                StorePrimaryButton(
                  onTap: () => pickImageFromGalary(),
                  icon: Icons.image_rounded,
                  title: "المعرض",
                  width: 90.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      images = selectedImage;
    });
  }

  Future pickImageFromGalary() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      images = selectedImage;
    });
  }
}
