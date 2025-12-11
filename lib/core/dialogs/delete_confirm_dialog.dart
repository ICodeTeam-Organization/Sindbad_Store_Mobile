import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Future<bool?> showDeleteConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String cancelText = 'الغاء',
  String okText = 'موافق',
  required Function onConfirm,
  String subtitle = '',
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap one of the buttons
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, false),
                    child: Icon(
                      Icons.close,
                      size: 24.sp,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 60.w,
                height: 60.h,
                child: SvgPicture.asset('assets/svgs/delete_icon.svg'),
              ),
              SizedBox(height: 20.h),
              Text(
                "هل انت متاكد من الحذف؟",
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => onConfirm(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Colors.red.withAlpha(20),
                        side: BorderSide.none,
                      ),
                      child: Text("نعم, متابعة الحذف",
                          style: const TextStyle(
                            color: Color(0xFFDE3838),
                          )),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Color(0xff00498B).withAlpha(20),
                        side: BorderSide.none,
                      ),
                      child: Text("لا,إالغاء العملية",
                          style: TextStyle(color: const Color(0xff00498B))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
