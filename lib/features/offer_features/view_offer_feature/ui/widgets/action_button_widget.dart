import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class ActionButtonWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final bool? isSolid;
  final double? width;
  final double? height;
  final void Function()? onTap;
  const ActionButtonWidget(
      {super.key,
      required this.iconPath,
      required this.title,
      this.isSolid = true,
      this.onTap,
      this.width = 120,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 120.w,
      decoration: isSolid == true
          ? BoxDecoration(
              color: AppColors.black, borderRadius: BorderRadius.circular(5))
          : BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: AppColors.primary,
              )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            iconPath,
            //               width: 20.w,
            //               height: 17.5.h,
          ),
          Text(
            title,
            style: isSolid == true
                ? KTextStyle.textStyle11.copyWith(
                    color: AppColors.white,
                  )
                : KTextStyle.textStyle10.copyWith(
                    color: AppColors.greyLight,
                  ),
          ),
        ],
      ),
    );
  }
}
