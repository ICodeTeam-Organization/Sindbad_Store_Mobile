import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class TextDiscountPricesWidget extends StatelessWidget {
  final String title;
  final String content;
  final bool? isBeforeDiscount;
  const TextDiscountPricesWidget({
    super.key,
    required this.title,
    required this.content,
    this.isBeforeDiscount = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: KTextStyle.textStyle11.copyWith(
            color: AppColors.greyLight,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          content,
          style: KTextStyle.textStyle13.copyWith(
            color: AppColors.greyDark,
            decoration:
                isBeforeDiscount == true ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}
