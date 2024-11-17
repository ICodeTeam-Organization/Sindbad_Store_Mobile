import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class TextForm extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType textInputType;

  const TextForm(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.textInputType});

  @override
  State<TextForm> createState() => _TextForm();
}

class _TextForm extends State<TextForm> {
  final _formfield = GlobalKey<FormState>();
  // final phoneController = TextEditingController();

  // Constants for repeated values
  static const double _height = 70.0;
  static const double _paddingLabelTextRight = 10.0;
  static const double _padding = 16.0;
  static const double _borderRadius = 15.0;


  @override
  Widget build(BuildContext context) {

    // [qais] => don`t use the container here 
    // because it is a heavy widget and you only want a hight and color properties
    // use sizedbox and box decoration instead

    return Container(
      height: _height.h,
      color: Color(0xffF6F5F6),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: _paddingLabelTextRight.w),
            child: Text(
              widget.labelText,
              ////
              style: TextStyle(
                color: AppColors.greyHint,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),

              ///
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: _padding.h, horizontal: _padding.w),
              child: TextFormField(
                key: _formfield,
                keyboardType: widget.textInputType,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(_borderRadius.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyHint, width: 1.0.w),
                    borderRadius: BorderRadius.all(Radius.circular(_borderRadius.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.redLight, width: 2.0.w),
                    borderRadius: BorderRadius.all(Radius.circular(_borderRadius.r)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
