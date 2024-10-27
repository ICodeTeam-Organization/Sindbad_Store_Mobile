import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/down_content.dart';

class AllDownContent extends StatelessWidget {
  const AllDownContent({
    super.key,
    required this.category,
    required this.discountRate,
    required this.bouns,
  });

  final String category;
  final String discountRate;
  final String bouns;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85.h,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: const BoxDecoration(color: AppColors.scaffColor),
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DownContent(
            categorys: category,
            categorysTitle: 'الصنف:  ',
          ),
          DownContent(
            categorys: discountRate,
            categorysTitle: 'نسبة الخصم:  ',
          ),
          DownContent(
            categorys: bouns,
            categorysTitle: 'البونص:  ',
          ),
        ],
      ),
    );
  }
}
