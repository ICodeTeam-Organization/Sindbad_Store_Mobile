import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class CustomShowDialogForViewWidget extends StatelessWidget {
  final bool? isLoading;
  final String title;
  final String subtitle;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final String? iconPath;
  const CustomShowDialogForViewWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.iconPath,
    this.confirmText,
    this.cancelText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25.r)),
        // height: 320.h,
        // width: 390.w,
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
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: iconPath == null
                        ? AppColors.redOpacity
                        : AppColors.greenOpacity,
                    child: SvgPicture.asset(
                      iconPath ?? "assets/delete.svg",
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    title,
                    style: KTextStyle.textStyle18.copyWith(
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
                  const SizedBox(height: 24),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // =======================  Confirm Button
                      Expanded(
                        flex: 8,
                        child: InkWell(
                            onTap: isLoading == true ? null : onConfirm,
                            child: Container(
                                alignment: Alignment.center,
                                height: 40.h,
                                // width: 130.w,
                                decoration: BoxDecoration(
                                    color: AppColors.redOpacity,
                                    borderRadius: BorderRadius.circular(10)),
                                child: isLoading == true
                                    ? SizedBox(
                                        height: 25
                                            .h, // ضمان التناسق بين العرض والطول.
                                        width: 25.h,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(confirmText ?? 'نعم , متابعة الحذف',
                                        style: KTextStyle.textStyle13.copyWith(
                                          color: AppColors.redDark,
                                        )))),
                      ),
                      Spacer(flex: 1),
                      // ========================  Cancel Button
                      Expanded(
                        flex: 8,
                        child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                                alignment: Alignment.center,
                                height: 40.h,
                                // width: 130.w,
                                decoration: BoxDecoration(
                                    color: AppColors.blueOpacity,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(cancelText ?? 'لا , إلغاء العملية',
                                    style: KTextStyle.textStyle13.copyWith(
                                      color: AppColors.blueDark,
                                    )))),
                      ),
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
