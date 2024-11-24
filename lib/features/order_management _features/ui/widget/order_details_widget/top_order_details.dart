import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

class TopOrderDetails extends StatelessWidget {
  const TopOrderDetails({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productType,
    required this.productTypeCat,
    required this.productTypeCat1,
    required this.productTypeCat2,
  });
  final String imageUrl;
  final String productName;
  final String productType;
  final String productTypeCat;
  final String productTypeCat1;
  final String productTypeCat2;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 91.w,
        height: 91.h,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey, width: 2),
            borderRadius: BorderRadius.circular(8.r)),
        child: Image.asset(
          imageUrl,
          width: 90.w,
          height: 90.h,
          fit: BoxFit.contain,
        ),
      ),
      title: Row(
        children: [
          Text(
            'اسم المنتج :  ',
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            productName,
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                'نوع المنتج :  ',
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                productType,
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                productTypeCat,
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                productTypeCat1,
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              Text('|'),
              Spacer(),
              Text(
                productTypeCat2,
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
