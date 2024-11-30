import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'button_custom.dart';

class TwoButtonInsideListViewProducts extends StatelessWidget {
  const TwoButtonInsideListViewProducts({
    super.key,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  final void Function() onTapEdit;
  final void Function() onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(text: 'تعديل', icon: Icons.edit, onPressed: onTapEdit),
        SizedBox(height: 5.h),
        CustomButton(text: 'حذف', icon: Icons.delete, onPressed: onTapDelete),
      ],
    );
  }
}
