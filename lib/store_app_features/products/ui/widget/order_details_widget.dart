import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.bondNum,
    required this.title,
  });

  final String bondNum;
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
          bondNum,
          style:
              KTextStyle.secondaryTitle.copyWith(fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
