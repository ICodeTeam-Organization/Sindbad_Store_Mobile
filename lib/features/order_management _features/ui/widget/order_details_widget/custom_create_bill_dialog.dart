import 'package:flutter/material.dart';
import 'build_dialog_content.dart';
import 'build_dialog_title.dart';

class CustomCreateBillDialog extends StatelessWidget {
  const CustomCreateBillDialog({
    super.key,
    this.isLoading = false,
    required this.headTitle,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
    required this.dateController,
    required this.numberController,
    required this.mountController,
  });
  final bool? isLoading;

  final String headTitle;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  //
  final TextEditingController dateController;
  final TextEditingController numberController;
  final TextEditingController mountController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitle(
        headTitle: headTitle,
        numberController: numberController,
        mountController: mountController,
        dateController: dateController,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildDialogContent(
        dateController: dateController,
        numberController: numberController,
        mountController: mountController,
        isLoading: isLoading,
        firstTitle: firstTitle,
        secondTitle: secondTitle,
        thierdTitle: thierdTitle,
        onPressedSure: onPressedSure,
      ),
    );
  }
}
