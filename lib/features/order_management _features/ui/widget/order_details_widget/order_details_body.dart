import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/Colors.dart';
import 'bottom_order_details.dart';
import 'mid_order_details.dart';
import 'top_order_details.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.0.w),
            padding: EdgeInsets.all(10),
            height: 244.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: Column(
              children: [
                //Dispaly image and product
                TopOrderDetails(
                  imageUrl: 'assets/laptop.png',
                  productName: 'MacBook Air',
                  productType: 'لابتوب',
                  productTypeCat: 'القرص الصلب',
                  productTypeCat1: '512GB',
                  productTypeCat2: 'الرام : GB8',
                ),
                //dispaly amount , price and total
                MidOrderDetails(
                  productMount: index,
                  productPrice: index * 2,
                ),
                /////////////
                Divider(),
                //Display barcode
                BottomOrderDetails(
                  barcodeNumber: 123546789 + index,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
