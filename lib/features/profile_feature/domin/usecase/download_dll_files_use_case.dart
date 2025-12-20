import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';

class DownloadAllFilesUseCase extends MyUseCase<String, void> {
  final ExcellRepositoryImpl excellRepositoryImpl;

  DownloadAllFilesUseCase(this.excellRepositoryImpl);

  @override
  Future<Either<DataFailed, DataSuccess<String>>> call({void params}) async {
    try {
      final filesResult = await excellRepositoryImpl.getFilesNames();

      return filesResult.fold(
        (failure) => Left(failure),
        (success) async {
          final List<FileModel> files = success.data ?? [];
          String savedDirectory = "";

          for (var file in files) {
            print("DEBUG: Downloading file: ${file.strTField}"); // Add this
            if (file.strTField.isEmpty) continue;

            final downloadResult =
                await excellRepositoryImpl.downloadFile(file.strTField);

            // Handle download failure
            if (downloadResult.isLeft()) {
              return downloadResult.fold(
                (failure) => Left(failure),
                (_) => Left(DataFailed("Unexpected error")),
              );
            }

            // Extract bytes from success
            final bytes = downloadResult.fold(
              (_) => <int>[],
              (success) => success.data ?? <int>[],
            );

            savedDirectory = await excellRepositoryImpl.saveFileLocally(
              bytes,
              file.strTField.split('/').last,
            );
          }

          return Right(DataSuccess(savedDirectory));
        },
      );
    } catch (e) {
      return Left(DataFailed("Failed: $e"));
    }
  }
}
