// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/shared_widgets/q_pop_icon.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';

// class StoreAppBar extends StatelessWidget {
//   const StoreAppBar({super.key, required this.nameAppbar, required this.isHome, /*this.accountAppbar8*/});
//   final String nameAppbar;
//   //final String? accountAppbar;
//     final bool isHome;


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//         color: AppColors.backgroundColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.2),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//       ),
//       child: AppBar(
//             title:  Text(
//               nameAppbar, style: TextStyle(
//                 color: Colors.black , 
//                 fontSize: 30.sp, fontWeight: FontWeight.bold)),
//             centerTitle: true,
//             // backgroundColor: AppColors.primaryButtonColor,
//             backgroundColor: AppColors.backgroundColor,
//             // leading:  const PopIcon(),
//             leading:  isHome ? null : const PopIcon(), 
//             // actions: [
//             //   Container(
//             //     margin: const EdgeInsets.all(8),
//             //     alignment: Alignment.center,
//             //     height: 25.h,
//             //     width: 25.w,
//             //     decoration:  BoxDecoration(
//             //       color: Colors.red,
//             //       borderRadius: BorderRadius.circular(100)
//             //     ),
//             //     child: Text(accountAppbar!,style:  TextStyle(color: Colors.white,fontSize: 14.sp),)),
//             // ],
//           ),
//     );
//   }
// }