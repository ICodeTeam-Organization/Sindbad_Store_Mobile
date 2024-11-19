import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

class StorePrimaryButton extends StatelessWidget {
  StorePrimaryButton(
      {super.key,
      this.onTap,
      this.height = 44,
      this.title = '',
      this.width = 370,
      this.icon,
      this.textColor = AppColors.white,
      this.buttonColor = AppColors.primary});

  double? width;
  double? height;
  String? title;
  GestureTapCallback? onTap;
  IconData? icon;
  Color? buttonColor;
  Color? textColor;

  // Constants for repeated values
  static const double _borderRadius = 8.0;
  static const double _iconSize = 24.0;

  /// Creates a store primary button widget.
  ///
  /// The [title] parameter must not be null.

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      /// [qais] => Don't use the {Container} here because it is a heavy widget.
      /// Instead, use the Alignment widget to align stuff and use the SizedBox
      /// widget within it to specify the width and height and Use the BoxDecoration widget
      /// within it to handle the decoration.

      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadiusDirectional.circular(_borderRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (icon != null)
              Icon(
                icon,
                color: AppColors.white,
                size: _iconSize.w,
              ),
            Text(title ?? '',
                style: KTextStyle.textStyle14.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}
