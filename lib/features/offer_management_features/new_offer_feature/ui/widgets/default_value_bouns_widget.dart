import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/counter_quantity_widget.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class DefaultValueBounsWidget extends StatelessWidget {
  final int buysCount;
  final int freesCount;
  final ValueChanged<int> onBuysCountChanged;
  final ValueChanged<int> onFreesCountChanged;

  const DefaultValueBounsWidget({
    Key? key,
    required this.buysCount,
    required this.freesCount,
    required this.onBuysCountChanged,
    required this.onFreesCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'كمية شراء المنتج المطلوبة للحصول على العرض ',
              style: KTextStyle.textStyle9.copyWith(
                color: AppColors.blackDark,
              ),
            ),
            CounterQuantityWidget(
              number: buysCount,
              onChanged: onBuysCountChanged, // Notify parent
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'الكمية التي سيحصل عليها العميل من نفس المنتج ',
              style: KTextStyle.textStyle9.copyWith(
                color: AppColors.blackDark,
              ),
            ),
            CounterQuantityWidget(
              number: freesCount,
              onChanged: onFreesCountChanged, // Notify parent
            ),
          ],
        ),
      ],
    );
  }
}
