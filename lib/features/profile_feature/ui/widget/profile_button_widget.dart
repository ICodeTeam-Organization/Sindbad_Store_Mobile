import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? switchButtton;
  final Function()? onTap;

  const ProfileButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.switchButtton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 10.h),
      child: Material(
        color: Colors.transparent, // transparent background for ripple
        borderRadius: BorderRadius.circular(20),
        elevation: 0,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.grey.withOpacity(0.1),
          highlightColor: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: double.infinity,
            height: 50.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: KTextStyle.textStyle16.copyWith(
                      color: Colors.grey[700],
                    ),
                  ),
                  switchButtton ??
                      Icon(
                        icon,
                        color: Colors.grey,
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
