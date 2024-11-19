import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../core/styles/Colors.dart';

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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.redOpacity,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 8.h,
              ),
              StorePrimaryButton(
                onTap: () => pickImageFromCamera(),
                icon: Icons.camera_alt,
                title: "الكاميرا",
                width: 145.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              StorePrimaryButton(
                onTap: () => pickImageFromGalary(),
                icon: Icons.image_rounded,
                title: "المعرض",
                width: 145.w,
              ),
              SizedBox(
                height: 10.h,
              ),
              selectedImage != null
                  ? SizedBox(
                      height: 200.h,
                      width: 200,
                      child: Image.file(selectedImage!),
                    )
                  : const Text(""),
            ],
          ),
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
