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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      color: Color(0xffF6F5F6),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.0.w),
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
                  EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
              child: TextFormField(
                key: _formfield,
                keyboardType: widget.textInputType,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.greyHint, width: 1.0.w),
                    borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.redLight, width: 2.0.w),
                    borderRadius: BorderRadius.all(Radius.circular(15.0.r)),
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
