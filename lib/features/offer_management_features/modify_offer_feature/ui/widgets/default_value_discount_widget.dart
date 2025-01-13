import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class DefaultValueDiscountWidget extends StatefulWidget {
  final int discountRate;
  final ValueChanged<int> onDiscountRateChanged;
  const DefaultValueDiscountWidget({
    super.key,
    required this.discountRate,
    required this.onDiscountRateChanged,
  });

  @override
  State<DefaultValueDiscountWidget> createState() =>
      _DefaultValueDiscountWidgetState();
}

class _DefaultValueDiscountWidgetState
    extends State<DefaultValueDiscountWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نسبة الخصم',
          style: KTextStyle.textStyle13.copyWith(
            color: AppColors.greyLight,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 45.h, // Adjusted height
          width: 150.w, // Adjusted width
          child: TextFormField(
            initialValue: widget.discountRate.toStringAsFixed(0),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter
                  .digitsOnly, // Allows only numeric input
              TextInputFormatter.withFunction((oldValue, newValue) {
                if (newValue.text.isEmpty) {
                  return newValue;
                }
                final int? number = int.tryParse(newValue.text);
                if (number == null || number < 1 || number > 100) {
                  return oldValue; // Reject input if it's not in range 0-100
                }
                return newValue; // Accept valid input
              }),
            ],
            onChanged: (value) {
              if (value.isNotEmpty && double.tryParse(value) != null) {
                final int newValue = int.parse(value);
                if (newValue >= 1 && newValue <= 100) {
                  setState(() {
                    widget.onDiscountRateChanged(newValue);
                  });
                }
              } else {
                setState(() {
                  widget.onDiscountRateChanged(0);
                });
              }
            },
            style: KTextStyle.textStyle12.copyWith(
              color: AppColors.blackLight,
            ),
            textAlign: TextAlign.center, // Center-align text horizontally
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: 4.h, // Reduced vertical padding
                horizontal: 4.w, // Reduced horizontal padding
              ),
              prefixIcon: Padding(
                padding:
                    EdgeInsets.only(left: 4.w, right: 4.w), // Padding for icon
                child: Icon(
                  Icons.percent,
                  color: AppColors.greyLight,
                  size: 16, // Adjusted size of the icon
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: 16.w,
                minHeight: 16.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.greyBorder,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
