import 'package:flutter/material.dart';
import '../order_details_widget/build_dialog_title.dart';
import 'build_shipping_dialog_content.dart';

class CustomOrderShippingDialog extends StatelessWidget {
  const CustomOrderShippingDialog({
    super.key,
    this.isLoading = false,
    required this.headTitle,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
  });
  final bool? isLoading;
  final String headTitle;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitle(
        headTitle: headTitle,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildShippingDialogContent(
        isLoading: isLoading,
        firstTitle: firstTitle,
        secondTitle: secondTitle,
        thierdTitle: thierdTitle,
        onPressedSure: onPressedSure,
      ),
    );
  }
}
