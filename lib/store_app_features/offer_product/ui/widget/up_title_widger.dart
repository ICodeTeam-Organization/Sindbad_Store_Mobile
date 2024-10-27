import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class UpTitleWidget extends StatelessWidget {
  const UpTitleWidget({
    super.key,
    required this.upTital,
  });
  final String upTital;

  @override
  Widget build(BuildContext context) {
    return Text(
      upTital,
      style: KTextStyle.secondaryTitle.copyWith(color: AppColors.greyHint),
    );
  }
}
