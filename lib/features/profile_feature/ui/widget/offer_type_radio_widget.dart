import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/custom_radio_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: l10n.discountType),
        SizedBox(height: 10.h),
        CustomRadioWidget(
          title: l10n.discountAmount,
          value: 'Percent',
          selectedOption: selectedOption,
          onChanged: onChangedDiscount,
        ),
        CustomRadioWidget(
          title: l10n.buyXGetY,
          value: 'Bonus',
          selectedOption: selectedOption,
          onChanged: onChangedBouns,
        ),
      ],
    );
  }
}
