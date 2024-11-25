import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/route.dart';
import '../../../function/status_helper.dart';
import '../../order_body.dart';

class PreparingInfoOrder extends StatelessWidget {
  const PreparingInfoOrder({
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
      itemCount: 4,
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
            orderNumber: '111111111',
            billNumber: '123456789',
            clock: '4:15',
            date: '2024/11/23',
            itemNumber: '25',
            paymentInfo: 'لا يوجد',
            orderStatus: '3',
          ),
        );
      },
    );
  }
}
