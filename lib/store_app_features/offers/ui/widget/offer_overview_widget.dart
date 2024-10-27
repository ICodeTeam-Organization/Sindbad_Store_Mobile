import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/all_down_content.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/all_up_content.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/button_execute.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/mid_content.dart';

class OfferOverviewWidget extends StatelessWidget {
  const OfferOverviewWidget({
    super.key,
    required this.offerStart,
    required this.offerFinish,
    required this.offerType,
    required this.excelFile,
    required this.category,
    required this.discountRate,
    required this.bouns,
  });

  final String offerStart;
  final String offerFinish;
  final String offerType;
  final String excelFile;
  final String category;
  final String discountRate;
  final String bouns;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.w),
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.r),
            color: AppColors.primaryColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey, offset: Offset(-1, 1), blurRadius: 1)
            ]),
        width: 370.w,
        height: 500.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
              child: AllUpContent(
                  offerStart: offerStart,
                  offerFinish: offerFinish,
                  offerType: offerType),
            ),
            MidContent(excelFile: excelFile),
            AllDownContent(
                category: category, discountRate: discountRate, bouns: bouns),
            SizedBox(
              height: 250.h,
            ),
            const ButtonExecute()
          ],
        ));
  }
}
