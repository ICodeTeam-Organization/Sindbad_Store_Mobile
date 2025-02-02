import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

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
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyBorder),
                  borderRadius: BorderRadius.circular(25.r),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      logo,
                      Text(
                        title,
                        style: KTextStyle.textStyle16.copyWith(
                          color: AppColors.blackDark,
                        ),
                      ),
                      Text(
                        subTitle,
                        textAlign: TextAlign.center,
                        style: KTextStyle.textStyle12.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      extra ?? SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
