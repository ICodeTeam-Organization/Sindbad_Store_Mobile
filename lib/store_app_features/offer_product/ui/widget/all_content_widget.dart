import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/content_widget.dart';

class AllContentWidget extends StatelessWidget {
  const AllContentWidget({
    super.key,
    required this.productNum,
    required this.productName,
  });

  final String productNum;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      decoration: BoxDecoration(
          color: AppColors.scaffColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          ContentWidget(
            contentInfo: productNum,
            contentTitle: 'رقم المنتج:   ',
          ),
          ContentWidget(
            contentInfo: productName,
            contentTitle: 'اسم المنتج:  ',
          ),
        ],
      ),
    );
  }
}
