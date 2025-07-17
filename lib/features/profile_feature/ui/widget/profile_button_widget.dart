import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class ProfileButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? switchButtton;
  final Function()? onTap;
  const ProfileButton(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.switchButtton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 10.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: KTextStyle.textStyle16.copyWith(
                    color: Colors.grey,
                  ),
                ),
                switchButtton == null
                    ? SizedBox(width: 10.w)
                    : SizedBox.shrink(),
                switchButtton != null
                    ? switchButtton ?? SizedBox.shrink()
                    : Icon(
                        icon,
                        color: Colors.grey,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
