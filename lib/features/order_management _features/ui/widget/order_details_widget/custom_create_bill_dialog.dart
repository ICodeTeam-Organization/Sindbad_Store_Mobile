import 'package:flutter/material.dart';
import 'build_dialog_content.dart';
import 'build_dialog_title.dart';

class CustomCreateBillDialog extends StatelessWidget {
  const CustomCreateBillDialog({
    super.key,
    this.isLoading = false,
    required this.onPressedSure,
    required this.dateController,
    required this.numberController,
    required this.mountController,
  });
  final bool? isLoading;
  final GestureTapCallback onPressedSure;
  //
  final TextEditingController dateController;
  final TextEditingController numberController;
  final TextEditingController mountController;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitle(
        headTitle: "بيانات الفاتورة",
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
        onPressedSure: onPressedSure,
      ),
    );
  }
}
