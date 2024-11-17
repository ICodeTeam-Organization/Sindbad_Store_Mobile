import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  PrimaryButton(
      {super.key,
      this.onTap,
      this.height,
      this.title,
      this.width,
      this.icon,
      this.buttonColor});
  double? width = 370.w;
  double? height = 44.w;
  String? title = '';
  GestureTapCallback? onTap;
  IconData? icon;
  Color? buttonColor = AppColors.colorButton;

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
