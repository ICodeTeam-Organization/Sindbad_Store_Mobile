import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ImageForSubImages extends StatelessWidget {
  const ImageForSubImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/download-03.svg",
      width: 24.w,
      height: 24.h,
    );
  }
}
