import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class RemainingNotice extends StatelessWidget {
  final dynamic remainingDays;
  final String? specialCase;
  const RemainingNotice({
    super.key,
    required this.remainingDays,
    this.specialCase,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '( متبقي ',
          style: KTextStyle.textStyle8.copyWith(
            color: AppColors.greyLight,
          ),
        ),
        Text(
          remainingDays.toString(),
          style: KTextStyle.textStyle8.copyWith(
            color: AppColors.primary,
          ),
        ),
        Text(
          '$specialCaseعلى الانتهاء',
          style: KTextStyle.textStyle8.copyWith(
            color: AppColors.greyLight,
          ),
        ),
      ],
    );
  }
}
