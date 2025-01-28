import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

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
        ? Row(
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
                '$specialCaseعلى الانتهاء )',
                style: KTextStyle.textStyle8.copyWith(
                  color: AppColors.greyLight,
                ),
              ),
            ],
          )
        : Text(
            ' (  انتهاء العرض  ) ',
            style: KTextStyle.textStyle8.copyWith(
              color: AppColors.greyLight,
            ),
          );
  }
}
