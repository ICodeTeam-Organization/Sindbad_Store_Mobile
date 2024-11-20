import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

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
  String? pay;

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
            style: KTextStyle.textStyle12,
          ),
          SizedBox(
            width: 10.w,
          ),
          Radio(
              activeColor: AppColors.redAccentColor,
              value: 'cash',
              groupValue: pay,
              onChanged: (val) {
                setState(() {
                  pay = val;
                });
              }),
          Text('نقد'),
          Radio(
              activeColor: AppColors.redAccentColor,
              value: 'later',
              groupValue: pay,
              onChanged: (val) {
                setState(() {
                  pay = val;
                });
              }),
          Text('اجل'),
        ],
      ),
    );
  }
}
