import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class ProductDiscountTileWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isEnable;
  final bool? isPrice;
  final void Function(String)? onChanged;
  final num? oldPrice;
  const ProductDiscountTileWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.isEnable,
    this.onChanged,
    this.oldPrice = 101,
    this.isPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    bool ifSmallScreen = widthScreen == 360;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: KTextStyle.textStyle9.copyWith(
            color: AppColors.blackLight,
          ),
        ),
        SizedBox(width: ifSmallScreen ? 5.h : 10.h),
        SizedBox(
          height: 30.h,
          width: ifSmallScreen ? 60.w : 80.w,
          child: TextFormField(
            controller: controller,

            //
            readOnly: isEnable == false ? true : false,
            keyboardType: isEnable == false ? null : TextInputType.number,
            inputFormatters: isEnable == false
                ? null
                : [
                    FilteringTextInputFormatter
                        .digitsOnly, // Allow only numeric input
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      if (newValue.text.isEmpty) {
                        return newValue; // Allow empty input for clearing
                      }
                      final int? value = int.tryParse(newValue.text);
                      if (value == null || value < 1 || value > oldPrice! - 1) {
                        return oldValue; // Reject invalid input
                      }
                      return newValue; // Accept valid input
                    }),
                  ],
            onChanged: isEnable == false ? null : onChanged,
            //
            style: KTextStyle.textStyle10.copyWith(
              color:
                  isEnable == false ? AppColors.blackLight : AppColors.primary,
            ),
            textAlign: isPrice == true ? TextAlign.end : TextAlign.center,
            decoration: InputDecoration(
              prefixIcon: isPrice == false
                  ? Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Icon(
                        Icons.percent,
                        color: AppColors.greyLight,
                        size: 16,
                      ),
                    )
                  : null,
              prefixIconConstraints: isPrice == false
                  ? BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.h,
                    )
                  : null,
              suffixIcon: isPrice == true
                  ? Padding(
                      padding: EdgeInsets.only(left: 4.w, right: 4.w),
                      child: Text(
                        'ر.س',
                        style: KTextStyle.textStyle10.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                    )
                  : null,
              suffixIconConstraints: isPrice == true
                  ? BoxConstraints(
                      minWidth: 16.w,
                      minHeight: 16.h,
                    )
                  : null,

              contentPadding: EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 4.w,
              ),
              filled: true,
              //
              fillColor: isEnable == false
                  ? AppColors.primaryBackground
                  : AppColors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isEnable == false
                      ? AppColors.primaryBackground
                      : AppColors.greyBorder,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isEnable == false
                      ? AppColors.primaryBackground
                      : AppColors.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              //
            ),
          ),
        ),
      ],
    );
  }
}
