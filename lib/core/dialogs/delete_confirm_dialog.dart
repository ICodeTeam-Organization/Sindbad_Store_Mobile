import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';

Future<bool?> showDeleteConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String cancelText = 'Cancel',
  String okText = 'OK',
  required Function onConfirm,
  String subtitle = '',
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // user must tap one of the buttons
    builder: (context) {
      final theme = Theme.of(context);

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
                      color: theme.hintColor,
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
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: theme.hintColor,
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
                        backgroundColor: theme.colorScheme.error.withAlpha(20),
                        side: BorderSide.none,
                      ),
                      child: Text(okText,
                          style: TextStyle(
                            color: theme.colorScheme.error,
                          )),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: theme.brightness == Brightness.light
                            ? const Color(0xff00498B).withAlpha(20)
                            : theme.colorScheme.primary.withAlpha(20),
                        side: BorderSide.none,
                      ),
                      child: Text(cancelText,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: theme.brightness == Brightness.light
                                  ? const Color(0xff00498B)
                                  : theme.colorScheme.primary)),
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
