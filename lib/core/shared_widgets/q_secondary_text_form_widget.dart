// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class SecondaryTextFormWidget extends StatelessWidget {
//   const SecondaryTextFormWidget({super.key, required this.texthint});
//   final String texthint ;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       height: 30.h,
//       width: 150.w,
//       margin: const EdgeInsets.all(5),
//       child: TextFormField(
//               decoration:  InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100.r),
//                   borderSide:  BorderSide(
//                     color: Colors.black,
//                     width: 1.w
//                   )
//                 ),
//                 focusedBorder:  OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(100.r),
//                   borderSide:  BorderSide(
//                     color: Colors.black,
//                     width: 1.w
//                   )
//                 ),
//                 //prefixIcon: const Icon(Icons.search),
//                 hintText: texthint,
//                 hintStyle: TextStyle( color: const Color.fromARGB(255, 80, 80, 80), fontSize: 16.sp,)
//               ),
//             ),
//     );
//   }
// }