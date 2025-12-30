import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/counter_quantity_widget.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class CounterQuantityTileWidget extends StatelessWidget {
  final String title;
  final int value;
  final ValueChanged<int> onChanged;

  const CounterQuantityTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Table(
            children: [
              TableRow(
                children: [
                  Text(
                    title,
                    style: KTextStyle.textStyle9.copyWith(
                      color: AppColors.blackDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        CounterQuantityWidget(
          number: value,
          onChanged: onChanged, // Notify parent
        ),
      ],
    );
  }
}
