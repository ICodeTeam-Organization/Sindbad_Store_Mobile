import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/styles/colors.dart';

class CheckBoxCustom extends StatelessWidget {
  final bool val;
  final void Function(bool?) onChanged;
  const CheckBoxCustom({
    super.key,
    required this.val,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Transform.scale(
        scale: 0.8,
        child: Checkbox(
          value: val,
          onChanged: onChanged,
          activeColor: AppColors.redDark,
          checkColor: AppColors.white,
          side: BorderSide(
            color: Colors.red,
            width: 1.0.w,
          ),
        ),
      ),
    );
  }
}
