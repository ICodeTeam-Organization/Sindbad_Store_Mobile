import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: KTextStyle.secondaryTitle.copyWith(color: AppColors.greyHint),
    );
  }
}
