import 'package:flutter/material.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class RemainingNoticeWidget extends StatelessWidget {
  final dynamic remainingDays;
  final String? specialCase;
  final bool? isRemainingDays;
  const RemainingNoticeWidget({
    super.key,
    required this.remainingDays,
    this.specialCase,
    this.isRemainingDays,
  });

  @override
  Widget build(BuildContext context) {
    return isRemainingDays == true
        ? Text.rich(
            TextSpan(
              style: KTextStyle.textStyle10.copyWith(
                color: AppColors.greyDark,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '( متبقي ',
                ),
                TextSpan(
                  text: remainingDays.toString(),
                  style: TextStyle(color: AppColors.primary),
                ),
                TextSpan(
                  text: '$specialCaseعلى الانتهاء )',
                ),
              ],
            ),
          )
        : Text(
            ' (  انتهاء العرض  ) ',
            style: KTextStyle.textStyle10.copyWith(
              color: AppColors.greyDark,
            ),
          );
  }
}
