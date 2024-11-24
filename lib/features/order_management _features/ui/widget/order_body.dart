import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import '../function/status_helper.dart';
import 'order_management_widget/bottom_info_order.dart';
import 'order_management_widget/top_info_order.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({
    super.key,
    required this.orderNumber,
    required this.billNumber,
    required this.clock,
    required this.date,
    required this.itemNumber,
    required this.paymentInfo,
    required this.orderStatus,
  });
  final String orderNumber;
  final String billNumber;
  final String clock;
  final String date;
  final int itemNumber;

  final String paymentInfo;
  final int orderStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey),
        borderRadius: BorderRadius.circular(16.r),
      ),
      height: 160.h,
      width: 380.w,
      child: Column(
        children: [
          TopInfoOrder(
            orderNumber: orderNumber,
            billNumber: billNumber,
            color: StatusHelper.getColor(orderStatus),
          ),
          SizedBox(
            height: 10.h,
          ),
          BottomInfoOrder(clock: clock, date: date, itemNumber: itemNumber),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Text('بيانات السداد : ', style: KTextStyle.textStyle12),
                Text(paymentInfo, style: KTextStyle.textStyle12)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
