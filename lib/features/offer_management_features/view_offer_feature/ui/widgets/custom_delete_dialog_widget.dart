import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomDeleteDialogWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final bool? isDelete;
  final String? iconPath;
  const CustomDeleteDialogWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.iconPath,
    this.isDelete = true,
    this.confirmText,
    this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25.r)),
        height: 320.h,
        width: 390.w,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button (X)
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: AppColors.greyIcon),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Icon delete_dialog
                  isDelete == true
                      ? CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.redOpacity,
                          child: SvgPicture.asset(
                            "assets/delete.svg",
                            width: 25.w,
                            height: 25.h,
                          ),
                        )
                      : CircleAvatar(
                          radius: 25,
                          backgroundColor: AppColors.greenOpacity,
                          child: SvgPicture.asset(
                            iconPath!,
                            width: 25.w,
                            height: 25.h,
                          ),
                        ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    title,
                    style: KTextStyle.textStyle20.copyWith(
                      color: AppColors.blackDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    subtitle,
                    style: KTextStyle.textStyle16.copyWith(
                      color: AppColors.greyLight,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Confirm Button
                      InkWell(
                          onTap: onConfirm,
                          child: isDelete == true
                              ? Container(
                                  alignment: Alignment.center,
                                  height: 40.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.redOpacity,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text('نعم , متابعة الحذف',
                                      style: KTextStyle.textStyle13.copyWith(
                                        color: AppColors.redDark,
                                      )))
                              : Container(
                                  alignment: Alignment.center,
                                  height: 40.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.greenOpacity,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                      confirmText ?? 'نعم , متابعة الحذف',
                                      style: KTextStyle.textStyle13.copyWith(
                                        color: Colors.green,
                                      )))),
                      // Cancel Button
                      InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                              alignment: Alignment.center,
                              height: 40.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  color: AppColors.blueOpacity,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(cancelText ?? 'لا , إلغاء العملية',
                                  style: KTextStyle.textStyle13.copyWith(
                                    color: AppColors.blueDark,
                                  )))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
