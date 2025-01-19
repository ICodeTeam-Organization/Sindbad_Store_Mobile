import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomDialogWidget extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final bool? isDelete;
  final bool? isLoading;
  final String? iconPath;
  const CustomDialogWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.iconPath,
    this.isDelete = true,
    this.isLoading = false,
    this.confirmText,
    this.cancelText,
  });

  @override
  State<CustomDialogWidget> createState() => _CustomDialogWidgetState();
}

class _CustomDialogWidgetState extends State<CustomDialogWidget> {
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
                  widget.isDelete == true
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
                            widget.iconPath!,
                            width: 25.w,
                            height: 25.h,
                          ),
                        ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    widget.title,
                    style: KTextStyle.textStyle18.copyWith(
                      color: AppColors.blackDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    widget.subtitle,
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
                          onTap: widget.onConfirm,
                          child: widget.isDelete == true
                              ? widget.isLoading == false
                                  ? Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.redOpacity,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text('نعم , متابعة الحذف',
                                          style:
                                              KTextStyle.textStyle13.copyWith(
                                            color: AppColors.redDark,
                                          )))
                                  : Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.redOpacity,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.transparent,
                                        child: CircularProgressIndicator(
                                          strokeAlign: -2,
                                          // strokeWidth: 5,
                                          color: AppColors.redDark,
                                        ),
                                      ),
                                    )
                              : widget.isLoading == false
                                  ? Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.greenOpacity,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                          widget.confirmText ??
                                              'نعم , متابعة الحذف',
                                          style:
                                              KTextStyle.textStyle13.copyWith(
                                            color: Colors.green,
                                          )))
                                  : Container(
                                      alignment: Alignment.center,
                                      height: 40.h,
                                      width: 130.w,
                                      decoration: BoxDecoration(
                                          color: AppColors.greenOpacity,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: CircleAvatar(
                                        backgroundColor: AppColors.transparent,
                                        child: CircularProgressIndicator(
                                          strokeAlign: -2,
                                          // strokeWidth: 5,
                                          color: Colors.green,
                                        ),
                                      ))),
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
                              child: Text(
                                  widget.cancelText ?? 'لا , إلغاء العملية',
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
