import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/styles/Colors.dart';

// ignore: must_be_immutable
class StorePrimaryButton extends StatefulWidget {
  StorePrimaryButton(
      {super.key,
      this.onTap,
      this.isLoading = false,
      this.disabled,
      this.height = 44,
      this.title = '',
      this.width = 140,
      this.icon,
      this.svgIconPath,
      this.textColor = AppColors.white,
      this.buttonColor = AppColors.primary});

  bool? isLoading;
  bool? disabled;
  double? width;
  double? height;
  String? title;
  GestureTapCallback? onTap;
  IconData? icon;
  String? svgIconPath;
  Color? buttonColor;
  Color? textColor;

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
      child: Container(
        alignment: Alignment.center,
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color:
              widget.disabled == true ? Color(0xFFD9D9D9) : widget.buttonColor,
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
                  if (widget.svgIconPath != null)
                    SvgPicture.asset(
                      widget.svgIconPath!,
                      width: StorePrimaryButton._iconSize.w,
                      height: StorePrimaryButton._iconSize.w,
                      colorFilter: ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    )
                  else if (widget.icon != null)
                    Icon(
                      widget.icon,
                      color: AppColors.white,
                      size: StorePrimaryButton._iconSize.w,
                    ),
                  Text(widget.title ?? '',
                      textAlign: TextAlign.center,
                      // matches text-align: center
                      style: TextTheme.of(context)
                          .titleSmall!
                          .copyWith(color: Colors.white))
                ],
              ),
      ),
    );
  }
}
