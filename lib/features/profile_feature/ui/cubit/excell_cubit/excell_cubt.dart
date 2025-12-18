import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/file_download_params.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/upload_excel_params.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/download_dll_files_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/download_file_usecase.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/post_files_usecase.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_states.dart';

class ExcelCubit extends Cubit<ExcelState> {
  final DownloadAllFilesUseCase _downloadAllFilesUseCase;
  final DownloadFileUseCase _downloadFileUseCase;
  final UploadExcelFileUseCase _uploadExcelFileUseCase;

  ExcelCubit(this._downloadAllFilesUseCase, this._downloadFileUseCase,
      this._uploadExcelFileUseCase)
      : super(ExcellInitial());

  Future<void> downloadAllFiles() async {
    emit(ExcellLoadInProgress());

    final result = await _downloadAllFilesUseCase();

    result.fold(
      (failure) {
        emit(ExcellLoadFailure(failure.error));
      },
      (success) {
        emit(ExcellLoadSuccess(success.data!));
      },
    );
  }

  Future<void> downloadFile(String url, String fileName) async {
    emit(ExcellLoadInProgress());

    final result = await _downloadFileUseCase(
        params: DownloadFileParams(url: url, fileName: fileName));

    result.fold(
      (failure) {
        emit(ExcellLoadFailure(failure.error));
      },
      (success) {
        emit(ExcellLoadSuccess(success.data!));
      },
    );
  }

  Future<void> uploadFile({
    required String filePath,
    required String action,
    String? storeId,
    bool? isOfficial,
  }) async {
    emit(ExcellLoadInProgress());

    final result = await _uploadExcelFileUseCase(
      params: UploadExcelParams(
        filePath: filePath,
        action: action,
        storeId: storeId,
        isOfficial: isOfficial,
      ),
    );

    result.fold(
      (failure) {
        emit(ExcellLoadFailure(failure.error));
      },
      (success) {
        emit(ExcellUploadSuccess(success.data!));
      },
    );
  }
}
