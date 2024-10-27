import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class InfoTextListView extends StatelessWidget {
  const InfoTextListView({
    super.key,
    required this.info,
    required this.title,
  });

  final String info;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: KTextStyle.secondaryTitle.copyWith(color: AppColors.greyHint),
        ),
        Text(
          info,
          style:
              KTextStyle.secondaryTitle.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
