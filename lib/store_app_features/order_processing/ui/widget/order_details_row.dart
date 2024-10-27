import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class OrderDetailsRow extends StatelessWidget {
  const OrderDetailsRow({
    super.key,
    required this.numberOrder,
    required this.titleOrder,
  });

  final String numberOrder;
  final String titleOrder;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(titleOrder,
            style: KTextStyle.secondaryTitle.copyWith(color: AppColors.white)),
        Text(
          numberOrder,
          style: KTextStyle.secondaryTitle
              .copyWith(fontWeight: FontWeight.w400, color: AppColors.white),
        )
      ],
    );
  }
}
