import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';

class DownloadFileUseCase extends MyUseCase<String, String> {
  final ExcellRepositoryImpl excellRepositoryImpl;

  DownloadFileUseCase(this.excellRepositoryImpl);

  @override
  Future<Either<DataFailed, DataSuccess<String>>> call({void params}) async {
    try {
      // final List<FileModel> files = await excellRepositoryImpl.getFilesNames();
      // String savedDirectory = "";

      // for (var file in files) {
      //   if (file.strTField.isEmpty) continue;

      //   final bytes = await excellRepositoryImpl.downloadFile(file.strTField);
      //   savedDirectory = await excellRepositoryImpl.saveFileLocally(
      //     bytes,
      //     file.strTField.split('/').last,
      //   );
      // }

      return Right(DataSuccess("savedDirectory"));
    } catch (e) {
      return Left(DataFailed("Failed: $e"));
    }
  }
}
