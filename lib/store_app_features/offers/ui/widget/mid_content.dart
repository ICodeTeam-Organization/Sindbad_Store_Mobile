import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class MidContent extends StatelessWidget {
  const MidContent({
    super.key,
    required this.excelFile,
  });

  final String excelFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(" الاصناف: ",
            style: KTextStyle.textStyle12.copyWith(color: AppColors.greyHint)),
        Text(excelFile, style: KTextStyle.secondaryTitle),
      ],
    );
  }
}
