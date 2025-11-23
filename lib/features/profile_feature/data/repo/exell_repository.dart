import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/excell_api_services.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/repo/excell_repository.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/download_dll_files_use_case.dart';

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
    // Request storage permission (Android)
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          throw Exception('Storage permission denied');
        }
      }
    }

    // Get directory
    String dirPath;
    if (Platform.isAndroid) {
      dirPath = '/storage/emulated/0/Download';
    } else {
      final dir = await getApplicationDocumentsDirectory();
      dirPath = dir.path;
    }

    final filePath = '$dirPath/$filename';
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    return filePath;
  }
}
