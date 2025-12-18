import 'package:flutter/material.dart';
import 'package:open_folder/open_folder.dart';

/// Shows a styled snackbar indicating a successful file download.
///
/// [context] - The BuildContext to show the snackbar in.
/// [folderPath] - The path to the folder where the file was saved.
void showDownloadSnackBar(
    BuildContext context, String folderPath, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blueGrey.shade900,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 6),
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.greenAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: "فتح المجلد",
        textColor: Colors.tealAccent,
        onPressed: () async {
          final result = await OpenFolder.openFolder(folderPath);

          if (result.isSuccess) {
            print('Folder opened successfully');
          } else {
            print('Error: ${result.message}');
          }
        },
      ),
    ),
  );
}
