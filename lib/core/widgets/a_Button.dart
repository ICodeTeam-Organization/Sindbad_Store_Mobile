// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';
// import 'package:sindbad_management_app/core/styles/text_style.dart';
// import 'package:sindbad_management_app/core/utils/route.dart';

// class KButtonWidget extends StatelessWidget {
//   // const card({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 15.h),
//       child: Container(
//         width: 85.w,
//         height: 48.h,
//         decoration: BoxDecoration(
//           // color: Color.fromRGBO(226, 126, 126, 1),
//           borderRadius: BorderRadius.circular(200.r),
//           // border: Border.all()),
//         ),
//         child: FloatingActionButton(
//             backgroundColor: Color.fromRGBO(226, 126, 126, 1),
//             child: Text(
//               "إغلاق",
//               style: KTextStyle.tabs.copyWith(color: AppColors.white),
//             ),
//             onPressed: () {
//               GoRouter.of(context)
//                   .pushReplacement(AppRouter.deliveryRouters.kDeliverHomePage);
//             }),
//       ),
//     );
//   }
// }
