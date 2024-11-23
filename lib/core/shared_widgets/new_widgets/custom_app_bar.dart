import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

import '../../styles/Colors.dart';

class CustomAppBar extends StatelessWidget {
  final String tital;
  final void Function()? onBackPressed;
  final bool? isBack;
  final void Function()? onSearchPressed;
  final bool? isSearch;
  const CustomAppBar({
    super.key,
    required this.tital,
    this.onBackPressed,
    this.onSearchPressed,
    this.isBack = true,
    this.isSearch = true,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      height: 75.h,
      width: double.infinity.w,
      child: Stack(
        children: [
          isBack == true
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: onBackPressed,
                      iconSize: 24,
                      icon: SvgPicture.asset(
                        "assets/back_appbar.svg",
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
          Center(
            child: Text(
              tital,
              style: KTextStyle.textStyle20.copyWith(
                color: AppColors.blackDark,
              ),
            ),
          ),
          isSearch == true
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: IconButton(
                      onPressed: onSearchPressed,
                      iconSize: 24,
                      icon: SvgPicture.asset(
                        "assets/search_appbar.svg",
                        width: 40.w,
                        height: 40.w,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
