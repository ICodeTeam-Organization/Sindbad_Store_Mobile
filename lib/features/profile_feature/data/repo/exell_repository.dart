import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/excell_api_services.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/repo/excell_repository.dart';

class ExcellRepositoryImpl extends ExcellRepository {
  final BulkService _excellServices;
  ExcellRepositoryImpl(
    this._excellServices,
  );

  Future<List<FileModel>> getFilesNames() async {
    final result = await _excellServices.getFilesNames();
    return result;
  }

  Future<List<int>> downloadFile(String fileName) async {
    final result = await _excellServices.downloadFile(fileName);
    return result;
  }

  Future<List<int>> downloadSpecificFile(String fileName) async {
    final result = await _excellServices.downloadSpecificFile(fileName);
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

  /// Upload an Excel file with a specific action.
  ///
  /// [filePath] - Local path to the Excel file to upload
  /// [action] - Action string that determines the endpoint:
  ///   - 1: Bulk_AddPrdctsWthAllDtls
  ///   - 2-8: BulkProductsActions
  ///   - 31-49: BulkRecordStoreCats
  ///   - 101-109: GetImagesFromNetByText
  /// [storeId] - Optional store ID
  /// [isOfficial] - Optional official flag
  Future<Either<DataFailed, DataSuccess<Map<String, dynamic>>>>
      uploadExcelFile({
    required String filePath,
    required String action,
    String? storeId,
    bool? isOfficial,
  }) async {
    try {
      final response = await _excellServices.uploadExcelFile(
        filePath: filePath,
        action: action,
        storeId: storeId,
        isOfficial: isOfficial,
      );

      if (response.statusCode == 200) {
        final data = response.data is Map<String, dynamic>
            ? response.data as Map<String, dynamic>
            : {'success': true, 'data': response.data};
        return Right(DataSuccess(data));
      } else {
        return Left(DataFailed(
          "Upload failed | Status: ${response.statusCode} | ${response.statusMessage}",
        ));
      }
    } catch (e) {
      return Left(DataFailed("Upload failed: $e"));
    }
  }
}
