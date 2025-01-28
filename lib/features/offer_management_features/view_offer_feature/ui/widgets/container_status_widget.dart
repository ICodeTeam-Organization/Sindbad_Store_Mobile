import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class ContainerStatusWidget extends StatelessWidget {
  final Color color;
  final String iconPath;
  final String title;

  const ContainerStatusWidget({
    super.key,
    required this.color,
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 9.w,
            height: 9.h,
          ),
          Text(
            title,
            style: KTextStyle.textStyle11.copyWith(
              color: AppColors.blackLight,
            ),
          ),
        ],
      ),
    );
  }
}
