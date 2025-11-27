import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/excell_api_services.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/repo/excell_repository.dart';

class ExcellRepositoryImpl extends ExcellRepository {
  final BulkService ExcellServices;
  ExcellRepositoryImpl(
    this.ExcellServices,
  );

  Future<List<FileModel>> getFilesNames() async {
    final result = await ExcellServices.getFilesNames();
    return result;
  }

  Future<List<int>> downloadFile(String fileName) async {
    final result = await ExcellServices.downloadFile(fileName);
    return result;
  }

  Future<String> saveFileLocally(List<int> bytes, String filename) async {
    // Request storage permission (Android < 13)
    if (Platform.isAndroid) {
      // For Android 13+ (SDK 33), WRITE_EXTERNAL_STORAGE is not needed/allowed for public directories
      // but we might need it for older versions.
      // We can check SDK version or just check if permission is granted/denied.
      // Ideally, we should use a more robust check, but for now, let's keep it simple
      // and only request if strictly needed.

      // Note: On Android 13, Permission.storage returns denied always if targeting SDK 33+.
      // So we should only request it if SDK < 33.
      // Since we don't have device_info here easily, we'll try to rely on the fact that
      // writing to public Downloads is allowed on Android 11+ without permission (for own files).

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        // Only request if not granted. On Android 13 this might just fail silently or return permanently denied.
        // We'll attempt to request.
        await Permission.storage.request();
      }
    }

    String dirPath;
    if (Platform.isAndroid) {
      dirPath = '/storage/emulated/0/Download/Sindbad';
    } else {
      final dir = await getApplicationDocumentsDirectory();
      dirPath = '${dir.path}/Sindbad';
    }

    final directory = Directory(dirPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final filePath = '$dirPath/$filename';
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return dirPath; // Return the directory path so we can open it later
  }
}
