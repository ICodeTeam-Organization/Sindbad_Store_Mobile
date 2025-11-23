import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';

class DownloadAllFilesUseCase extends MyUseCase<List<String>, void> {
  final ExcellRepositoryImpl excellRepositoryImpl;

  DownloadAllFilesUseCase(this.excellRepositoryImpl);

  @override
  Future<Either<DataFailed, DataSuccess<List<String>>>> call(
      {void params}) async {
    try {
      final List<FileModel> files = await excellRepositoryImpl.getFilesNames();
      final List<String> savedPaths = [];

      for (var file in files) {
        if (file.strTField.isEmpty) continue;

        final bytes = await excellRepositoryImpl.downloadFile(file.strTField);
        final savedPath = await excellRepositoryImpl.saveFileLocally(
          bytes,
          file.strTField.split('/').last,
        );

        savedPaths.add(savedPath);
      }

      return Right(DataSuccess(savedPaths));
    } catch (e) {
      return Left(DataFailed("Failed: $e"));
    }
  }
}
