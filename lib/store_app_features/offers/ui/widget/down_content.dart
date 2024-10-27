import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class DownContent extends StatelessWidget {
  const DownContent({
    super.key,
    required this.categorys,
    required this.categorysTitle,
  });

  final String categorys;
  final String categorysTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(categorysTitle,
            style: KTextStyle.secondaryTitle
                .copyWith(fontWeight: FontWeight.w500)),
        Text(categorys, style: KTextStyle.secondaryTitle)
      ],
    );
  }
}
