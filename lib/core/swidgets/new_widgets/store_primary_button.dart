import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/styles/Colors.dart';
import '../../../config/styles/text_style.dart';

// ignore: must_be_immutable
class StorePrimaryButton extends StatefulWidget {
  StorePrimaryButton(
      {super.key,
      this.onTap,
      this.isLoading = false,
      this.disabled,
      this.height = 44,
      this.title = '',
      this.width = 370,
      this.icon,
      this.textColor = AppColors.white,
      this.buttonColor = AppColors.primary});

  bool? isLoading;
  bool? disabled;
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

  @override
  State<StorePrimaryButton> createState() => _StorePrimaryButtonState();
}

class _StorePrimaryButtonState extends State<StorePrimaryButton> {
  /// Creates a store primary button widget.
  ///
  /// The [widget.title] parameter must not be null.

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.disabled == true || widget.isLoading == true
          ? null
          : widget.onTap,

      /// [qais] => Don't use the {Container} here because it is a heavy widget.
      /// Instead, use the Alignment widget to align stuff and use the SizedBox
      /// widget within it to specify the width and height and Use the BoxDecoration widget
      /// within it to handle the decoration.

      child: Container(
        alignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color:
              widget.disabled == true ? AppColors.greyHint : widget.buttonColor,
          borderRadius: BorderRadiusDirectional.circular(
              StorePrimaryButton._borderRadius.r),
        ),
        child: widget.isLoading == true
            ? CircleAvatar(
                backgroundColor: AppColors.transparent,
                child: CircularProgressIndicator(
                  strokeAlign: -2,
                  // strokeWidth: 5,
                  color: AppColors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (widget.icon != null)
                    Icon(
                      widget.icon,
                      color: AppColors.white,
                      size: StorePrimaryButton._iconSize.w,
                    ),
                  Text(widget.title ?? '',
                      style: KTextStyle.textStyle14
                          .copyWith(color: widget.textColor)),
                ],
              ),
      ),
    );
  }
}
