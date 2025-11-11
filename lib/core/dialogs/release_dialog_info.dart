import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart' as intl;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindbad_management_app/core/resources/release.dart';

void showReleaseInfoDialog(
  BuildContext context, {
  required Release release,
}) async {
  // Initialize flutter_downloader
  await FlutterDownloader.initialize(debug: true);

  final releaseDate = intl.DateFormat.yMMMMd('ar').format(release.publishedAt);
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // GitHub API headers
  // final Map<String, String> githubHeaders = ;

  Future<bool> requestStoragePermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        final status = await Permission.storage.request();
        return status.isGranted;
      }
      return true; // No need for storage permission on Android 13+
    }
    return true; // iOS doesn't need these permissions
  }

  Future<String> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return (await getExternalStorageDirectory())?.path ??
          (await getApplicationDocumentsDirectory()).path;
    } else {
      return (await getApplicationDocumentsDirectory()).path;
    }
  }

  Future<void> downloadFile(String downloadLink, String filename) async {
    try {
      final hasPermission = await requestStoragePermissions();
      if (!hasPermission) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تم رفض الإذن المطلوب")));
        return;
      }

      final dir = await getDownloadDirectory();

      final taskId = await FlutterDownloader.enqueue(
        url: downloadLink,
        headers: {
          'Authorization':
              'Bearer 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',
          'Accept': 'application/octet-stream',
        },
        savedDir: '$dir/$filename',
        fileName: filename,
        showNotification: true,
        openFileFromNotification: true,
        requiresStorageNotLow: true,
      );

      if (taskId != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("بدأ التحميل...")));

        // Listen for download completion
        FlutterDownloader.registerCallback((id, status, progress) {
          if (id == taskId) {
            if (status == DownloadTaskStatus.complete) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("تم التحميل بنجاح")));
            } else if (status == DownloadTaskStatus.failed) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("فشل التحميل")));
            }
          }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("خطأ في التحميل: ${e.toString()}")));
    } finally {
      Navigator.pop(context);
    }
  }

  showDialog(
    context: context,
    builder: (context) => RtlDialog(
      title: 'معلومات الإصدار',
      children: [
        _buildInfoItem(Icons.new_releases, 'رقم الإصدار', release.tagName),
        _buildInfoItem(Icons.calendar_today, 'تاريخ النشر', releaseDate),
        if (release.name.isNotEmpty)
          _buildInfoItem(Icons.description, 'ملاحظات الإصدار', release.name),
        _buildInfoItem(Icons.person, 'المطور', "شركة iCODE"),
        _buildInfoItem(Icons.code, 'حالة الإصدار', 'الاخير'),
        if (release.assets.isNotEmpty)
          _buildInfoItem(Icons.storage, 'حجم الملف',
              '${(release.assets.first.size * (1024 * 1024)).toStringAsFixed(1)} MB'),
      ],
      onUpdatePressed: () {
        if (release.assets.isNotEmpty) {
          downloadFile(
              release.downloadApkLink, 'sindbad_${release.tagName}.apk');
        }
      },
    ),
  );
}

Widget _buildInfoItem(IconData icon, String label, String value) {
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        textDirection: TextDirection.rtl,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: Colors.blue[700]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class RtlDialog extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onUpdatePressed;

  const RtlDialog({
    super.key,
    required this.title,
    required this.children,
    required this.onUpdatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(height: 20),
            ...children,
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('إلغاء', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onUpdatePressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                  ),
                  child:
                      const Text('تحديث الآن', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
