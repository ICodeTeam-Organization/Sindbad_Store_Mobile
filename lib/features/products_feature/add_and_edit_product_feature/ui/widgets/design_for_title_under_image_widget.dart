import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/styles/Colors.dart';
import '../../../../../config/styles/text_style.dart';

class DesignForTitleUnderImage extends StatelessWidget {
  const DesignForTitleUnderImage({
    super.key,
    required this.title,
    required this.width,
    required this.height,
  });

  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.redOpacity,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0.r),
            bottomRight: Radius.circular(10.0.r),
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: KTextStyle.textStyle14.copyWith(color: AppColors.greyDark),
          ),
        ),
      ),
    );
  }
}
