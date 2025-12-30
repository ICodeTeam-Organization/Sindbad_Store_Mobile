import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class MenuButtonWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool? isSolid;
  final double? width;
  final double? height;
  final void Function()? onTap;
  const MenuButtonWidget(
      {super.key,
      required this.iconPath,
      required this.title,
      this.isSolid = true,
      this.onTap,
      this.width = 84,
      this.height = 32});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height!.h,
        constraints: BoxConstraints(
          minWidth: 84.w,
          maxWidth: 480.w,
        ),
        padding: EdgeInsets.only(left: 16.w, right: 8.w),
        decoration: isSolid == true
            ? BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
              )
            : BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              color: isSolid == false
                  ? theme.colorScheme.primary
                  : AppColors.white,
              iconPath,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              title,
              style: isSolid == true
                  ? KTextStyle.textStyle13.copyWith(
                      color: AppColors.white,
                    )
                  : KTextStyle.textStyle12.copyWith(
                      color: AppColors.greyLight,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
