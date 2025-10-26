import 'package:flutter/material.dart';

class ShowErrorDialoge extends StatelessWidget {
  final String errorMessage; // تمرير الرسالة كـ معطى

  const ShowErrorDialoge(
      {super.key, required this.errorMessage}); // التعديل هنا

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.bounceInOut,
          ),
        ),
        child: AlertDialog(
          title: Text(
            'خطأ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            errorMessage,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.right,
          ),
          actionsAlignment: MainAxisAlignment.start,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'حسناً',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // هذه الوظيفة لعرض الـ Dialog
  static Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShowErrorDialoge(errorMessage: errorMessage);
      },
    );
  }
}
