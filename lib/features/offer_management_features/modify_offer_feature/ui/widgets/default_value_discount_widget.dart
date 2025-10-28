import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

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
  late TextEditingController _controller;
  late int _discountRate;

  @override
  void initState() {
    super.initState();
    _discountRate = widget.discountRate;
    _controller = TextEditingController(text: _discountRate.toString());
  }

  @override
  void didUpdateWidget(DefaultValueDiscountWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.discountRate != oldWidget.discountRate) {
      _discountRate = widget.discountRate;
      _controller.text = _discountRate.toString();
    }
  }

  void _onTextChanged(String value) {
    if (value.isEmpty) {
      setState(() {
        _discountRate = 1;
        _controller.text = _discountRate.toString(); // Prevent empty text field
        widget.onDiscountRateChanged(_discountRate);
      });
    } else {
      final int? newValue = int.tryParse(value);
      if (newValue != null && newValue >= 1 && newValue <= 99) {
        setState(() {
          _discountRate = newValue;
          widget.onDiscountRateChanged(_discountRate);
        });
      } else {
        _controller.text =
            _discountRate.toString(); // Keep the last valid value
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        SizedBox(height: 10.h),
        SizedBox(
          height: 50.h, // Adjusted height
          width: 150.w, // Adjusted width
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly, // Only numeric input
            ],
            onChanged: _onTextChanged,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.white,
              contentPadding: EdgeInsets.symmetric(
                vertical: 4.h, // Reduced vertical padding
                horizontal: 4.w, // Reduced horizontal padding
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                child: Icon(
                  Icons.percent,
                  color: AppColors.greyLight,
                  size: 16,
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
