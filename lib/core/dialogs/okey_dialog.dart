import 'package:flutter/material.dart';

void showOkDialog({
  required BuildContext context,
  required String message,
  required String title,
}) {
  showDialog(
    context: context,
    builder: (context) => Directionality(
      textDirection: TextDirection.rtl, // Force RTL layout
      child: AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.right, // Right-align title
        ),
        content: Text(
          message,
          textAlign: TextAlign.right, // Right-align content
        ),
        actionsAlignment: MainAxisAlignment
            .start, // Align actions to the left (which will be right in RTL)
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'), // "OK" in Arabic
          ),
        ],
      ),
    ),
  );
}
