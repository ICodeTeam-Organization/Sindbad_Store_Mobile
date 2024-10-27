import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class ButtonExecute extends StatelessWidget {
  const ButtonExecute({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        KCustomPrimaryButtonWidget(buttonName: "تنفيذ", onPressed: () {})
      ],
    );
  }
}
