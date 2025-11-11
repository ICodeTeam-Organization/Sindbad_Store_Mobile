import 'package:flutter/material.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class TextGrayLightWidget extends StatelessWidget {
  const TextGrayLightWidget({
    super.key,
    required this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: KTextStyle.textStyle11.copyWith(
        color: AppColors.greyLight,
      ),
    );
  }
}
