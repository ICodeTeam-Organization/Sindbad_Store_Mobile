import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/store_app_features/products/ui/widget/order_details_body.dart';

class StoreProductListViewWidget extends StatelessWidget {
  const StoreProductListViewWidget({
    super.key,
    this.bondNum,
    this.date,
    this.itemNum,
  });
  final String? bondNum;
  final String? date;
  final String? itemNum;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 370.w,
        height: 550.h,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, i) {
              return const OrderDetailsBody(
                bondNum: '654654',
                date: '2024/10/2',
                itemNum: '5',
              );
            }));
  }
}
