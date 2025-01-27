import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

String? pay;

class RadioWidget extends StatefulWidget {
  const RadioWidget({
    super.key,
  });

  @override
  // ignore: no_logic_in_create_state
  State<RadioWidget> createState() => _RadioWidgetState(title: 'نوع الفاتورة');
}

class _RadioWidgetState extends State<RadioWidget> {
  final String title;

  _RadioWidgetState({required this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 10.w,
          ),
          Radio(
              activeColor: AppColors.redAccentColor,
              value: '2',
              groupValue: pay,
              onChanged: (val) {
                setState(() {
                  pay = val;
                });
              }),
          Text(
            'نقد',
            style: KTextStyle.textStyle12,
          ),
          Radio(
              activeColor: AppColors.redAccentColor,
              value: '1',
              groupValue: pay,
              onChanged: (val) {
                setState(() {
                  pay = val;
                });
              }),
          Text(
            'اجل',
            style: KTextStyle.textStyle12,
          ),
        ],
      ),
    );
  }
}
