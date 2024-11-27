import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/text_style.dart';

class TopInfoOrder extends StatelessWidget {
  const TopInfoOrder({
    super.key,
    required this.orderNumber,
    required this.billNumber,
    required this.color,
  });

  final String orderNumber;
  final String billNumber;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.only(top: 7),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                'رقم الطلب',
                style: KTextStyle.textStyle12,
              ),
              Text(
                orderNumber,
                style: KTextStyle.textStyle14,
              ),
            ],
          ),
          Column(
            children: [
              Text('رقم الفاتورة', style: KTextStyle.textStyle12),
              Text(
                billNumber,
                style: KTextStyle.textStyle14,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
