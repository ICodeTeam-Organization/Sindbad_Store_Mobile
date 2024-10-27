import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_data_dialog_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class ButtonBill extends StatelessWidget {
  const ButtonBill({
    super.key,
    required this.billDate,
    required this.billNumber,
    required this.billMount,
  });
  final String billDate;
  final String billNumber;
  final String billMount;

  @override
  Widget build(BuildContext context) {
    return KCustomPrimaryButtonWidget(
        buttonName: "الفاتورة",
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return CustomDataDialogWidget(
                  headTitle: 'بيانات الفاتورة',
                  firstTitle: 'التاريخ',
                  firstTitleContent: billDate,
                  secondTitle: 'رقم الفاتورة',
                  secondTitleContent: billNumber,
                  thierdTitle: 'قيمة الفاتورة',
                  thierdTitleContent: billMount,
                );
              });
        });
  }
}
