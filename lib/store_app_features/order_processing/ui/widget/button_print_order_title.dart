import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_print_dialog_widget.dart';

class ButtonPrintOrderTitle extends StatelessWidget {
  const ButtonPrintOrderTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KCustomPrimaryButtonWidget(
        buttonName: "طباعة عنوان الطلب",
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const KCustomPrintDialogWidget(
                    numberOfCopies: 2, printName: "");
              });
        });
  }
}
