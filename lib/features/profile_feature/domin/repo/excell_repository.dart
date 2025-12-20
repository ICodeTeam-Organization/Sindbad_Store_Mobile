import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/file_model.dart';

abstract class ExcellRepository {
  Future<Either<DataFailed, DataSuccess<List<FileModel>>>> getFilesNames();
  Future<Either<DataFailed, DataSuccess<List<int>>>> downloadFile(
      String fileName);
}
