import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class KImagePickerFunction extends StatefulWidget {
  const KImagePickerFunction({super.key});

  @override
  State<KImagePickerFunction> createState() => _KImagePickerFunctionState();
}

class _KImagePickerFunctionState extends State<KImagePickerFunction> {
  File? selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomIMageButton(
          onTap: () => pickImageFromCamera(),
          icon: Icons.camera_alt,
          title: "إلتقاط",
        ),
        SizedBox(
          height: 10.h,
        ),
        CustomIMageButton(
          onTap: () => pickImageFromGalary(),
          icon: Icons.image_rounded,
          title: "المعرض",
        ),

        // /////////
        // IconButton(
        // onPressed: (){
        //   pickImageFromGalary();
        // },
        // ////////////////////

        // icon: const Icon(Icons.image_rounded)),

        selectedImage != null ? Image.file(selectedImage!) : const Text(""),
        KCustomPrimaryButtonWidget(buttonName: "تاكيد", onPressed: () {})
      ],
    );
  }

  Future pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });
  }

  Future pickImageFromGalary() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
    });
  }
}

class CustomIMageButton extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;
  final String title;

  const CustomIMageButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: KTextStyle.secondaryTitle.copyWith(color: AppColors.white),
            ),
            const SizedBox(width: 10),
            Icon(
              icon,
              size: 25,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
