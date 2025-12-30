import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class CardMesssageWidget extends StatelessWidget {
  final Widget logo;
  final String title;
  final String subTitle;
  final Widget? extra;
  const CardMesssageWidget({
    super.key,
    required this.logo,
    required this.title,
    required this.subTitle,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final bgColor = isDark ? Colors.grey[850] : Colors.white;
    final borderColor = isDark ? Colors.grey[700]! : AppColors.greyBorder;
    final titleColor = theme.textTheme.bodyLarge?.color ?? AppColors.blackDark;
    final subtitleColor = isDark ? Colors.grey[400]! : AppColors.greyLight;

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(25.r),
          color: bgColor,
        ),
        alignment: Alignment.center,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              logo,
              Text(
                title,
                style: KTextStyle.textStyle16.copyWith(
                  color: titleColor,
                ),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: KTextStyle.textStyle12.copyWith(
                  color: subtitleColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: extra ?? SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
