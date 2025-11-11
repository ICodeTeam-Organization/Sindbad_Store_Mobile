import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/route.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import '../../../../config/styles/Colors.dart';
import '../../../../config/styles/text_style.dart';
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
  final String date;
  final String itemNumber;
  final String paymentInfo;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    Color orderColor;
    //بدون فاتورة
    if (orderStatus == '2') {
      orderColor = Color(0xffE8E8E8);
    }
    //لم تسدد
    else if (orderStatus == '3') {
      orderColor = Color(0xCCFFF2F5);
    }
    //للشحن
    else if (orderStatus == '4') {
      orderColor = Color(0xffCEECF0);
    }
    //السابقة
    else if (orderStatus == '5' || (orderStatus == '6')) {
      orderColor = Color(0xffCDE8F6);
    }
    //غيره
    else {
      orderColor = Colors.white;
    }
    return InkWell(
      onTap: () {
        idOrders = idOrder;
        idPackages = idPackage;
        orderNumbers = orderNumber;
        billNumbers = billNumber;
        dates = date;
        itemNumbers = itemNumber;
        paymentInfos = paymentInfo;
        orderStatuss = orderStatus;
        orderColors = orderColor;
        context.push(AppRoutes.details, extra: idPackage);
      },
      child: Container(
        margin: EdgeInsets.all(5),
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
            BottomInfoOrder(date: date, itemNumber: itemNumber),
            Container(
              padding: EdgeInsets.only(right: 35.w),
              child: Row(
                children: [
                  Text('بيانات السداد : ', style: KTextStyle.textStyle12),
                  Text(paymentInfo, style: KTextStyle.textStyle12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
