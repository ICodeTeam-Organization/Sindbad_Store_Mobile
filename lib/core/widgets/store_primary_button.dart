import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';

// ignore: must_be_immutable
class StorePrimaryButton extends StatelessWidget {
  StorePrimaryButton(
      {super.key,
      this.onTap,
      this.height = 44,
      this.title = '',
      this.width = 370,
      this.icon,
      this.buttonColor = AppColors.colorButton});
  double? width;
  double? height;
  String? title;
  GestureTapCallback? onTap;
  IconData? icon;

  Color? buttonColor;
  // = AppColors.colorButton

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadiusDirectional.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: AppColors.white,
                size: 24,
              ),
            Text(title ?? '',
                style: KTextStyle.textStyle14.copyWith(color: AppColors.white)),
          ],
        ),
      ),
    );
  }
}
