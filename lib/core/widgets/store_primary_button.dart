import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/styles/Colors.dart';

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
      this.textColor,
      this.buttonColor});

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Use widget colors if provided, otherwise use theme colors
    final effectiveButtonColor =
        widget.buttonColor ?? theme.colorScheme.primary;
    final effectiveTextColor = widget.textColor ?? theme.colorScheme.onPrimary;
    final disabledColor = isDark ? Colors.grey[700]! : Color(0xFFD9D9D9);

    return InkWell(
      onTap: widget.disabled == true || widget.isLoading == true
          ? null
          : widget.onTap,
      child: Container(
        alignment: Alignment.center,
        width: 140,
        height: 40,
        decoration: BoxDecoration(
          color: widget.disabled == true ? disabledColor : effectiveButtonColor,
          borderRadius: BorderRadiusDirectional.circular(
              StorePrimaryButton._borderRadius.r),
        ),
        child: widget.isLoading == true
            ? CircleAvatar(
                backgroundColor: AppColors.transparent,
                child: CircularProgressIndicator(
                  strokeAlign: -2,
                  color: effectiveTextColor,
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
                        effectiveTextColor,
                        BlendMode.srcIn,
                      ),
                    )
                  else if (widget.icon != null)
                    Icon(
                      widget.icon,
                      color: effectiveTextColor,
                      size: StorePrimaryButton._iconSize.w,
                    ),
                  Text(widget.title ?? '',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleSmall!
                          .copyWith(color: effectiveTextColor))
                ],
              ),
      ),
    );
  }
}
