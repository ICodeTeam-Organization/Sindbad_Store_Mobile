import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/counter_quantity_bouns_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/default_value_discount_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';

class OfferDefaultValueWidget extends StatelessWidget {
  final bool isDiscountDefaultValue;
  final int discountRate;
  final int numberToBuy;
  final int numberToGet;
  final void Function(int) onDiscountRateChanged;
  final void Function(int) onNumberToBuyChanged;
  final void Function(int) onNumberToGetChanged;
  const OfferDefaultValueWidget({
    super.key,
    required this.isDiscountDefaultValue,
    required this.discountRate,
    required this.numberToBuy,
    required this.numberToGet,
    required this.onDiscountRateChanged,
    required this.onNumberToBuyChanged,
    required this.onNumberToGetChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: 'القيمة الأفتراضية'),
        SizedBox(height: 20.h),
        isDiscountDefaultValue
            ? DefaultValueDiscountWidget(
                discountRate: discountRate,
                onDiscountRateChanged: onDiscountRateChanged,
              )
            : CounterQuantityBounsWidget(
                numberToBuy: numberToBuy,
                numberToGet: numberToGet,
                onNumberToBuyChanged: onNumberToBuyChanged,
                onNumberToGetChanged: onNumberToGetChanged,
              ),
      ],
    );
  }
}
