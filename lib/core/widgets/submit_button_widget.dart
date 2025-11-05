import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubmetButtonWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;

  const SubmetButtonWidget({
    super.key,
    required this.isActive,
    this.onPressed,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 47.h,
      decoration: BoxDecoration(
        color: !isActive
            ? Color(0xffffffff)
            : Color(0xffFF746B), //Color(0xffFF746B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
          onPressed: isActive ? onPressed : null,
          child: isLoading
              ? SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: isActive ? Color(0xffffffff) : Color(0xff636773),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )),
    );
  }
}
