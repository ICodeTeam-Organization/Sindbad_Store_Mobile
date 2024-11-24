import 'package:flutter/material.dart';

import 'build_shipping_dialog_content.dart';
import 'build_shipping_dialog_title.dart';

TextEditingController dateShippingConroller = TextEditingController();
TextEditingController numberShippingConroller = TextEditingController();
TextEditingController mountShippingConroller = TextEditingController();

class CustomOrderShippingDialog extends StatelessWidget {
  const CustomOrderShippingDialog(
      {super.key,
      required this.headTitle,
      required this.firstTitle,
      required this.secondTitle,
      required this.thierdTitle,
      required this.onPressedSure,
      required this.parcels});
  final String headTitle;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  final int parcels;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildShippingDialogTitle(
        headTitle: headTitle,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildShippingDialogContent(
        firstTitle: firstTitle,
        secondTitle: secondTitle,
        thierdTitle: thierdTitle,
        onPressedSure: onPressedSure,
        parcels: parcels,
      ),
    );
  }
}



// ignore: must_be_immutable

// class BuildShippingImageSection extends StatelessWidget {
//   const BuildShippingImageSection({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10.h),
//       width: MediaQuery.sizeOf(context).width,
//       decoration: BoxDecoration(
//           border: Border.all(color: AppColors.grey),
//           borderRadius: BorderRadius.circular(16.r)),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "صورة الفاتورة",
//                   style: KTextStyle.textStyle14,
//                 ),
//               ],
//             ),
//           ),
//           const ImagePickerFunction(),
//         ],
//       ),
//     );
//   }
// }

// File? images;

// class ImagePickerFunction extends StatefulWidget {
//   const ImagePickerFunction({super.key});

//   @override
//   State<ImagePickerFunction> createState() => _ImagePickerFunctionState();
// }

// class _ImagePickerFunctionState extends State<ImagePickerFunction> {
//   File? selectedImage;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: MediaQuery.sizeOf(context).width,
//         child: Column(
//           children: [
//             DecoratedBox(
//               decoration: BoxDecoration(
//                 color: AppColors.redOpacity,
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               child: DottedBorder(
//                 color: AppColors.redColor,
//                 radius: Radius.circular(16.r),
//                 strokeWidth: 1,
//                 dashPattern: [5, 10],
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     SizedBox(
//                       height: 207.h,
//                       width: 295.w,
//                       child: selectedImage != null
//                           ? SizedBox(
//                               height: 207.h,
//                               width: 295,
//                               child: Image.file(
//                                 selectedImage!,
//                                 fit: BoxFit.fill,
//                               ),
//                             )
//                           : const Text(""),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20.h,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 StorePrimaryButton(
//                   onTap: () => pickImageFromCamera(),
//                   icon: Icons.camera_alt,
//                   title: "الكاميرا",
//                   width: 80.w,
//                 ),
//                 SizedBox(
//                   width: 7.h,
//                 ),
//                 StorePrimaryButton(
//                   onTap: () => pickImageFromGalary(),
//                   icon: Icons.image_rounded,
//                   title: "المعرض",
//                   width: 80.w,
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Future pickImageFromCamera() async {
//     final returnImage =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (returnImage == null) return;
//     setState(() {
//       selectedImage = File(returnImage.path);
//       images = selectedImage;
//     });
//   }

//   Future pickImageFromGalary() async {
//     final returnImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (returnImage == null) return;
//     setState(() {
//       selectedImage = File(returnImage.path);
//       images = selectedImage;
//     });
//   }
// }
