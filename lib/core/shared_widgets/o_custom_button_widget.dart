// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';

// class CustomButtonWidget extends StatefulWidget {
//   const CustomButtonWidget({
//     super.key,
//     required this.buttonName,
//     required this.onPressed,
//     required this.width,
//     required this.height,
//   });

//   final String buttonName;
//   final GestureTapCallback onPressed;
//   final double width;
//   final double height;

//   @override
//   State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
// }

// class _CustomButtonWidgetState extends State<CustomButtonWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.onPressed,
//       child: Container(
//         alignment: Alignment.center,
//         width: widget.width.w,
//         height: widget.height.h,
//         decoration: BoxDecoration(
//           // color: Colors.red,
//           color: AppColors.redAccentColor,
//           borderRadius: BorderRadius.circular(18.r),
//         ),
//         child: Text(
//           widget.buttonName,
//           textAlign: TextAlign.center,
//           style:  TextStyle(
//             color: Colors.white,
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold
//             ),
//         ),
//       ),
//     );
//   }
// }