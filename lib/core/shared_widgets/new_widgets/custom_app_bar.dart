import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/utils/route.dart';

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
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: InkWell(
                        onTap:
                            onBackPressed ?? () => Navigator.of(context).pop(),
                        child: SvgPicture.asset(
                          "assets/back_appbar.svg",
                          width: 40.w,
                          height: 40.w,
                        ),
                      )),
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
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: onSearchPressed ??
                            () => GoRouter.of(context)
                                .push(AppRouter.storeRouters.notifiction),
                        child: Icon(Icons.notifications_none,
                            size: 30.w, color: AppColors.blackDark),
                      )),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
