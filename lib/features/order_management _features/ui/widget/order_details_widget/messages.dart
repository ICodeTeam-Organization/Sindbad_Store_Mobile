import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

// ignore: must_be_immutable
class Messages extends StatelessWidget {
  const Messages(
      {super.key,
      required this.isTrue,
      required this.trueMessage,
      required this.falseMessage});
  final bool isTrue;
  final String trueMessage;
  final String falseMessage;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: isTrue
          ? Center(
              child: SizedBox(
                width: 70.w,
                height: 70.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppColors.greenOpacity),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/done.svg",
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: SizedBox(
                width: 70.w,
                height: 70.h,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      color: AppColors.redOpacity),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/notDone.svg",
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                ),
              ),
            ),
      content: isTrue
          ? Text(
              trueMessage,
              // 'لقد تمت الأضافة في قائمة التجهيز',
              textAlign: TextAlign.center,
              style:
                  KTextStyle.textStyle16.copyWith(color: AppColors.greenDark),
            )
          : Text(
              falseMessage,
              // 'هناك خطاء في العملية',
              textAlign: TextAlign.center,
              style: KTextStyle.textStyle16.copyWith(color: AppColors.redDark),
            ),
    );
  }
}
