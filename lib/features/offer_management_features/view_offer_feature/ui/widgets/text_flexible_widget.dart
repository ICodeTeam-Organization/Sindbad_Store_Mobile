import 'package:flutter/material.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class TextFlexibleWidget extends StatelessWidget {
  final String title;
  final Color colorTitle;
  const TextFlexibleWidget({
    super.key,
    required this.title,
    required this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    bool ifSmallScreen = widthScreen == 360;
    TextStyle flexibleStyle =
        ifSmallScreen ? KTextStyle.textStyle11 : KTextStyle.textStyle12;

    return Text(
      title,
      style: flexibleStyle.copyWith(
        color: colorTitle,
      ),
    );
  }
}
