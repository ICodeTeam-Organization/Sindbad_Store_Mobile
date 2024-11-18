import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/Colors.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    required this.title,
    this.onPressed,
  });

  String title;
  VoidCallback? onPressed;

  // Constants for repeated values
  static const double _padding = 8.0;
  static const double _iconButtonHeight = 50.0;
  static const double _iconButtonWidth = 40.0;
  static const double _borderWidth = 2.0;
  static const double _borderRadius = 10.0;
  static const double _iconSize = 24.0;

////////////////////////////////////////
  /// Creates a custom app bar widget.
////////////////////////////////////////

  /// The [title] parameter must not be null.

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AppColors.primaryBackground,
      centerTitle: true,
      title: Text(
        title,
      ),
      actions: [

        // [qais] => Avoiding Heavy Widgets: using Container can be heavy because it is heavy widget.
        // You can replace it with lighter-weight widgets for better performance.
        // In this case, use Padding, SizedBox, and DecoratedBox instead of Container.

        Container(
          padding: EdgeInsets.symmetric(
            horizontal: _padding.h,
            vertical: _padding.w
          ),
          alignment: Alignment.center,
          height: _iconButtonHeight.h,
          width: _iconButtonWidth.w,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey, width: _borderWidth.r),
              borderRadius: BorderRadius.circular(_borderRadius.r),
              color: AppColors.primaryBackground),
          child: IconButton(
            onPressed: onPressed,
            padding: EdgeInsets.all(0),
            iconSize: _iconSize.w,
            color: Colors.black54,
            icon: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
