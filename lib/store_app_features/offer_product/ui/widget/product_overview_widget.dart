import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/all_content_widget.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/all_up_title_widget.dart';

class ProductOverviewWidget extends StatelessWidget {
  const ProductOverviewWidget({
    super.key,
    required this.productNum,
    required this.productName,
  });

  final String productNum;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      width: 323.w,
      height: 500.h,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          const AllUpTitleWidget(),
          // محتوى العرض
          AllContentWidget(productNum: productNum, productName: productName),
          SizedBox(
            height: 200.h,
          )
        ],
      ),
    );
  }
}
