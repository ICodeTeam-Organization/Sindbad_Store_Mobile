// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';

// class CustomAppBArWidget extends StatelessWidget {
//   const CustomAppBArWidget({super.key, required this.nameAppbar, required this.count , required this.isHome});
//   final String nameAppbar;
//   final int? count;
//   final bool isHome;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//           title:  Text(
//             nameAppbar, 
//             style: TextStyle(
//               color: Colors.black , fontSize: 25.sp, 
//               // fontWeight: FontWeight.bold
//               )),
//           centerTitle: true,
          
//           backgroundColor: AppColors.backgroundColor,
//           actions:
//           [ 
//             if(isHome != true) Padding(
//             padding:  EdgeInsets.only(
//               left:  40.0.w,
//               top: 8.0.h
//               ),
//             child: Text(
//               "($count)",
//               style: TextStyle(
//                 fontSize: 18.sp,
//                 color: Colors.red
//                 ),
//               ),
//           )]
         
//         );
//   }
// }