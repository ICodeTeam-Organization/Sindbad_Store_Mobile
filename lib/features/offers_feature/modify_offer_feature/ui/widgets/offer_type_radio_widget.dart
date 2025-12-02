import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/offers_feature/modify_offer_feature/ui/widgets/custom_radio_widget.dart';
import 'package:sindbad_management_app/features/offers_feature/modify_offer_feature/ui/widgets/section_title_widget.dart';

class OfferTypeRadioWidget extends StatelessWidget {
  final String? selectedOption;
  final void Function(String?)? onChangedDiscount;
  final void Function(String?)? onChangedBouns;
  const OfferTypeRadioWidget({
    super.key,
    required this.selectedOption,
    this.onChangedDiscount,
    this.onChangedBouns,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: 'نوع الخصم'),
        SizedBox(height: 10.h),
        CustomRadioWidget(
          title: 'خصم مبلغ من منتج',
          value: 'Percent',
          selectedOption: selectedOption,
          onChanged: onChangedDiscount,
        ),
        CustomRadioWidget(
          title: 'اشتري x واحصل على y',
          value: 'Bonus',
          selectedOption: selectedOption,
          onChanged: onChangedBouns,
        ),
      ],
    );
  }
}
