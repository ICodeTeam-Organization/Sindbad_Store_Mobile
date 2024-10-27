import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/order_details_row.dart';

class StoreOrderProcessingContainerBody extends StatelessWidget {
  const StoreOrderProcessingContainerBody({
    super.key,
    required this.numberOrder,
    required this.date,
    required this.numberItem,
  });
  final String numberOrder;
  final String date;
  final String numberItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
          color: const Color(0xff454545),
          borderRadius: BorderRadius.circular(10.r)),
      width: 344.w,
      height: 80.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OrderDetailsRow(
              numberOrder: numberOrder,
              titleOrder: 'رقم الطلب:  ',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OrderDetailsRow(
                  numberOrder: date,
                  titleOrder: 'التاريخ : ',
                ),
                OrderDetailsRow(
                  numberOrder: numberItem,
                  titleOrder: 'عدد الاصناف : ',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
