import 'package:flutter/material.dart';

void showErrorDialog({
  required BuildContext context,
  required String title,
  required String description,
  String buttonText = 'موافق',
}) {
  showDialog(
    context: context,
    barrierDismissible: false, // User must tap button to close
    builder: (context) => AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.right, // RTL alignment
      ),
      content: Text(
        description,
        textAlign: TextAlign.right, // RTL alignment
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(buttonText),
        ),
      ],
    ),
  );
}
