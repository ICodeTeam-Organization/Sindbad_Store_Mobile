import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class InvoiceAmount extends StatelessWidget {
  const InvoiceAmount({
    super.key,
    required this.totalPrices,
  });
  final num totalPrices;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 90.w,
          child: Text(
            "قيمة الفاتورة",
            style: KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 48.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey, width: 2.w),
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                  child: Text(
                '$totalPrices ر.س',
                style: KTextStyle.textStyle13,
              )),
            ),
          ),
        )
      ],
    );
  }
}
