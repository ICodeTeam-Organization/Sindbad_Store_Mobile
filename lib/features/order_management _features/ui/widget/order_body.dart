import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import 'order_management_widget/bottom_info_order.dart';
import 'order_management_widget/top_info_order.dart';

int? idOrders;
int? idPackages;
String? orderNumbers;
String? billNumbers;
String? clocks;
String? dates;
String? itemNumbers;
String? paymentInfos;
String? orderStatuss;
Color? orderColors;

class OrderBody extends StatelessWidget {
  const OrderBody({
    super.key,
    required this.idOrder,
    required this.orderNumber,
    required this.billNumber,
    required this.clock,
    required this.date,
    required this.itemNumber,
    required this.paymentInfo,
    required this.orderStatus,
    required this.idPackage,
  });
  final int idOrder;
  final int idPackage;
  final String orderNumber;
  final String billNumber;
  final String clock;
  final String date;
  final String itemNumber;
  final String paymentInfo;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    Color orderColor;

    switch (paymentInfo) {
      case 'Refunded':
        orderColor = Colors.yellow.shade50;
        break;
      case 'Paid':
        orderColor = Colors.green.shade50;
        break;
      case 'Unpaid':
        orderColor = Colors.red.shade50;
        break;
      default:
        orderColor = Colors.blue.shade50;
    }
    // final status = myStatuses[i];
    return InkWell(
      onTap: () {
        idOrders = idOrder;
        idPackages = idPackage;
        print("$idPackage ########################## $idPackages");
        orderNumbers = orderNumber;
        billNumbers = billNumber;
        clocks = clock;
        dates = date;
        itemNumbers = itemNumber;
        paymentInfos = paymentInfo;
        orderStatuss = orderStatus;
        orderColors = orderColor;
        context.push(AppRouter.storeRouters.details, extra: idPackage);
      },
      child: Container(
        margin: EdgeInsets.all(7),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(16.r),
        ),
        height: 140.h,
        width: 380.w,
        child: Column(
          children: [
            TopInfoOrder(
              orderNumber: orderNumber,
              billNumber: billNumber,
              color: orderColor,
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
      ),
    );
  }
}
