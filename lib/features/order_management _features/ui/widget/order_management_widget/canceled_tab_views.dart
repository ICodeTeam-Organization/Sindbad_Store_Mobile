import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import '../../../../../core/utils/route.dart';
import '../../function/status_helper.dart';
import '../order_body.dart';
import 'bottom_info_order.dart';
import 'top_info_order.dart';

class CanceledTabViews extends StatelessWidget {
  const CanceledTabViews({
    super.key,
    this.orderNumber,
    this.billNumber,
    this.clock,
    this.date,
    this.itemNumber,
    this.paymentInfo,
  });
  final String? orderNumber;
  final String? billNumber;
  final String? clock;
  final String? date;
  final int? itemNumber;
  final String? paymentInfo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        final status = myStatuses[index];
        return InkWell(
          onTap: () {
            context.push(
              AppRouter.storeRouters.details,
              // extra: idOrder,
            );
          },
          child: OrderBody(
            billNumber: '1111111',
            orderNumber: '123456789',
            clock: '4:14',
            date: '2024/11/23',
            itemNumber: '25',
            paymentInfo: 'لا يوجد',
            orderStatus: '6',
          ),
        );
      },
    );
  }
}
