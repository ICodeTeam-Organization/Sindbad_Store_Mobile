// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/shared_widgets/q_pop_icon.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';

// class AppBarWidget extends StatelessWidget {
//   const AppBarWidget({super.key, required this.nameAppbar, required this.accountAppbar});
//   final String nameAppbar;
//   final String? accountAppbar;

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//           title:  Text(nameAppbar, style: TextStyle(color: AppColors.secondaryColor , fontSize: 20.sp, fontWeight: FontWeight.w700)),
//           centerTitle: true,
//           backgroundColor: AppColors.primaryColor,
//           leading: const PopIcon(),
//           actions: [
//             Container(
//               margin: const EdgeInsets.all(8),
//               alignment: Alignment.center,
//               height: 25.h,
//               width: 25.w,
//               decoration:  BoxDecoration(
//                 color: Colors.transparent,
//                 borderRadius: BorderRadius.circular(100)
//               ),
//               child: Text(accountAppbar!,style:  TextStyle(color: Colors.red,fontSize: 14.sp, fontWeight: FontWeight.w700),)),

//           ],
//           shadowColor: Colors.black,
//           elevation: 3,
//         );
//   }
// }
