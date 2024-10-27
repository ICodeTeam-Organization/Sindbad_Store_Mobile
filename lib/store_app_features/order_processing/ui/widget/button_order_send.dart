import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_data_dialog_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class ButtonOrderSend extends StatelessWidget {
  const ButtonOrderSend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KCustomPrimaryButtonWidget(
        buttonName: "تم ارسال الطلب",
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return const CustomDataDialogWidget(
                  headTitle: 'بيانات الشحن',
                  firstTitle: 'التاريخ',
                  firstTitleContent: '2024/10/2',
                  secondTitle: 'رقم فاتورة الشحن',
                  secondTitleContent: '2102511025',
                  thierdTitle: 'شركة النقل',
                  thierdTitleContent: 'اسم الشركة الناقلة',
                );
              });
        });
  }
}
