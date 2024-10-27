// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';

// class StoreTextFormField extends StatelessWidget {
//   const StoreTextFormField({super.key});

//   @override
//   Widget build(BuildContext context) {
//           return Container(
//             margin: EdgeInsets.symmetric(vertical: 5.h),
//             alignment: Alignment.center,
//             width: 338.w,
//             height: 37.h,
//             decoration: BoxDecoration(
//               color: AppColors.primaryColor,
//               borderRadius: BorderRadius.circular(100.r)
//             ),
//             child: TextFormField(
//               decoration:  InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.r),
//                   borderSide:  BorderSide(
//                     color: AppColors.primaryColor,
//                     width: 1.w
//                   )
//                 ),
//                 focusedBorder:  OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.r),
//                   borderSide:  BorderSide(
//                     color: AppColors.primaryColor,
//                     width: 1.w
//                   )
//                 ),
//                 suffixIcon: const Icon(Icons.search),
//                 hintText: "بحث برقم الطلب"

//               ),
//             ),
//           );
//   }
// }