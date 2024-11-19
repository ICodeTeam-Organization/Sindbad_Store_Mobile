import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

import '../../styles/Colors.dart';

class CustomAppBar extends StatelessWidget {
  final String tital;
  final VoidCallback? onPressed;
  const CustomAppBar({
    super.key,
    this.onPressed,
    required this.tital,
  });
  @override
  Widget build(BuildContext context) {
    return 
    AppBar(
      backgroundColor: AppColors.white,
      toolbarHeight: 50.h,
      centerTitle: true,
      title: Text(
        tital, 
        style: KTextStyle.textStyle18.copyWith(color: AppColors.blackLight,),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            onPressed: onPressed,
            iconSize: 24,
            icon: SvgPicture.asset(
                      "assets/search_appbar.svg",
                      width: 40.w,
                      height: 40.w,
                    ),
          ),
        ),
      ],
    );
  }
}
