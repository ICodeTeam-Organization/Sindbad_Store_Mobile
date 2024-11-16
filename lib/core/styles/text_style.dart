import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class KTextStyle {
  static TextStyle textStyle20 =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500);
  static TextStyle textStyle18 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);
  static TextStyle textStyle16 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle textStyle14 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);
  static TextStyle textStyle12 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w700);
  //////////////////////////////////////////////
  ///Old
  static TextStyle primaryTitle =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold);
  static TextStyle tabs = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle secondaryTitle =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle buttonScreen = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
  );
}
