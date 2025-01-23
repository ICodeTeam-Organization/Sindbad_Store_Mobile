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
/*
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 220.h,
        width: 382.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // زر الإغلاق
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الديالوج
                },
                icon: Icon(
                  Icons.cancel_sharp,
                  color: Colors.grey,
                  size: 24.sp,
                ),
              ),
            ),
            // الأيقونة الدائرية
            CircleAvatar(
              radius: 30.0.r,
              backgroundColor: Colors.green.withOpacity(0.1),
              child: Image.asset("assets/Vector.png"),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            // الأزرار
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر "نعم، متابعة"
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "نعم، متابعة",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.green,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "لا، إلغاء العملية",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
*/
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 220.h,
        width: 382.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Close button (X)
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop(); // إغلاق الديالوج
                },
                icon: Icon(
                  Icons.cancel_sharp,
                  color: Colors.grey,
                  size: 24.sp,
                ),
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
                                    color: AppColors.redOpacity,
                                    borderRadius: BorderRadius.circular(10)),
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    widget.confirmText ?? 'نعم , متابعة الحذف',
                                    style: KTextStyle.textStyle13.copyWith(
                                      color: Colors.green,
                                    )))
                            : Container(
                                alignment: Alignment.center,
                                height: 40.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                    color: AppColors.greenOpacity,
                                    borderRadius: BorderRadius.circular(10)),
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
                        child: Text(widget.cancelText ?? 'لا , إلغاء العملية',
                            style: KTextStyle.textStyle13.copyWith(
                              color: AppColors.blueDark,
                            )))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
