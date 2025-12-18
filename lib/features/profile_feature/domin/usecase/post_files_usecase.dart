import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/resources/data_state.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/upload_excel_params.dart';

/// Use case for uploading Excel files with bulk actions
class UploadExcelFileUseCase
    extends MyUseCase<Map<String, dynamic>, UploadExcelParams> {
  final ExcellRepositoryImpl excellRepositoryImpl;

  UploadExcelFileUseCase(this.excellRepositoryImpl);

  @override
  Future<Either<DataFailed, DataSuccess<Map<String, dynamic>>>> call({
    UploadExcelParams? params,
  }) async {
    if (params == null) {
      return Left(DataFailed("Upload parameters are required"));
    }

    return excellRepositoryImpl.uploadExcelFile(
      filePath: params.filePath,
      action: params.action,
      storeId: params.storeId,
      isOfficial: params.isOfficial,
    );
  }
}
