import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/file_download_params.dart';

/// Parameters for downloading a file

class DownloadFileUseCase extends MyUseCase<String, DownloadFileParams> {
  final ExcellRepositoryImpl excellRepositoryImpl;

  DownloadFileUseCase(this.excellRepositoryImpl);

  @override
  Future<Either<DataFailed, DataSuccess<String>>> call(
      {DownloadFileParams? params, String? fileName}) async {
    try {
      if (params == null) {
        return Left(DataFailed("Download parameters are required"));
      }

      final fileUrl = params.url;
      final name = params.fileName;

      // Download the file bytes
      final bytes = await excellRepositoryImpl.downloadSpecificFile(fileUrl);

      // Save the file locally and get the directory path
      final savedDirectory = await excellRepositoryImpl.saveFileLocally(
        bytes,
        name,
      );

      return Right(DataSuccess(savedDirectory));
    } catch (e) {
      return Left(DataFailed("Download failed: $e"));
    }
  }
}
