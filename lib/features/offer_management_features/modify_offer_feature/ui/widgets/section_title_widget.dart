import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class SectionTitleWidget extends StatelessWidget {
  final String title;
  const SectionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: KTextStyle.textStyle14.copyWith(
        color: AppColors.blackLight,
      ),
    );
  }
}
