import 'package:flutter/material.dart';

import '../order_details_widget/build_dialog_title.dart';
import 'build_shipping_dialog_content.dart';

TextEditingController dateShippingConroller = TextEditingController();
TextEditingController numberShippingConroller = TextEditingController();
TextEditingController mountShippingConroller = TextEditingController();

class CustomOrderShippingDialog extends StatelessWidget {
  const CustomOrderShippingDialog(
      {super.key,
      required this.headTitle,
      required this.firstTitle,
      required this.secondTitle,
      required this.thierdTitle,
      required this.onPressedSure,
      required this.parcels});
  final String headTitle;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  final int parcels;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitle(
        headTitle: headTitle,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildShippingDialogContent(
        firstTitle: firstTitle,
        secondTitle: secondTitle,
        thierdTitle: thierdTitle,
        onPressedSure: onPressedSure,
        parcels: parcels,
      ),
    );
  }
}
