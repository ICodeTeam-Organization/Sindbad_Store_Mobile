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
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }

    String dirPath;
    if (Platform.isAndroid) {
      // Use getExternalStorageDirectory() for scoped storage compatibility (Android 10+)
      // This returns the app's private external storage directory which doesn't require
      // special permissions on Android 10+
      final externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        dirPath = '${externalDir.path}/Sindbad';
      } else {
        // Fallback to app documents directory
        final docDir = await getApplicationDocumentsDirectory();
        dirPath = '${docDir.path}/Sindbad';
      }
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
