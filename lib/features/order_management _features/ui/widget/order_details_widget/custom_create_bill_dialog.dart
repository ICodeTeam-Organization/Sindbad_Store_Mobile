import 'package:flutter/material.dart';
import 'build_dialog_content.dart';
import 'build_dialog_title.dart';

class CustomCreateBillDialog extends StatelessWidget {
  const CustomCreateBillDialog(
      {super.key,
      this.isLoading = false,
      required this.headTitle,
      required this.firstTitle,
      required this.secondTitle,
      required this.thierdTitle,
      required this.onPressedSure});
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
      content: BuildDialogContent(
        isLoading: isLoading,
        firstTitle: firstTitle,
        secondTitle: secondTitle,
        thierdTitle: thierdTitle,
        onPressedSure: onPressedSure,
      ),
    );
  }
}
