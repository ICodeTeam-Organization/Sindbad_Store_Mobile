import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/offer_overview_widget.dart';

class StoreListViewOffer extends StatelessWidget {
  const StoreListViewOffer(
      {super.key,
      this.offerStart,
      this.offerFinish,
      this.excelFile,
      this.offerType,
      this.category,
      this.discountRate,
      this.bouns});
  final String? offerStart;
  final String? offerFinish;
  final String? offerType;
  final String? excelFile;
  final String? category;
  final String? discountRate;
  final String? bouns;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370.w,
      height: 530.h,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, i) {
            return const OfferOverviewWidget(
              offerStart: '2024/10/2',
              offerFinish: '2024/10/4',
              offerType: 'خصم/بونص',
              excelFile: 'ملف اكسل',
              category: '',
              discountRate: '',
              bouns: '',
            );
          }),
    );
  }
}
