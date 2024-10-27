import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/store_app_features/products/ui/widget/order_details_widget.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    super.key,
    required this.bondNum,
    required this.date,
    required this.itemNum,
  });

  final String bondNum;
  final String date;
  final String itemNum;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      height: 100.h,
      width: 343.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.primaryColor,
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(-1, 1), blurRadius: 1)
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OrderDetailsWidget(
            bondNum: bondNum,
            title: 'رقم الطلب:  ',
          ),
          OrderDetailsWidget(
            bondNum: date,
            title: 'التاريخ:  ',
          ),
          OrderDetailsWidget(
            bondNum: itemNum,
            title: 'عدد الاصناف:   ',
          ),
        ],
      ),
    );
  }
}
