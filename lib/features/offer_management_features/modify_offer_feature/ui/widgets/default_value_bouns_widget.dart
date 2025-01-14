import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/counter_quantity_widget.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class DefaultValueBounsWidget extends StatelessWidget {
  final int numberToBuy;
  final int numberToGet;
  final ValueChanged<int> onNumberToBuyChanged;
  final ValueChanged<int> onNumberToGetChanged;

  const DefaultValueBounsWidget({
    Key? key,
    required this.numberToBuy,
    required this.numberToGet,
    required this.onNumberToBuyChanged,
    required this.onNumberToGetChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        'كمية شراء المنتج المطلوبة للحصول على العرض ',
                        style: KTextStyle.textStyle9.copyWith(
                          color: AppColors.blackDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CounterQuantityWidget(
              number: numberToBuy,
              onChanged: onNumberToBuyChanged, // Notify parent
            ),
          ],
        ),
        SizedBox(height: 5.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        'الكمية التي سيحصل عليها العميل من نفس المنتج ',
                        style: KTextStyle.textStyle9.copyWith(
                          color: AppColors.blackDark,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CounterQuantityWidget(
              number: numberToGet,
              onChanged: onNumberToGetChanged, // Notify parent
            ),
          ],
        ),
      ],
    );
  }
}
