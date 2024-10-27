import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class ButtonSure extends StatelessWidget {
  const ButtonSure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        KCustomPrimaryButtonWidget(buttonName: "تاكيد", onPressed: () {})
      ],
    );
  }
}
