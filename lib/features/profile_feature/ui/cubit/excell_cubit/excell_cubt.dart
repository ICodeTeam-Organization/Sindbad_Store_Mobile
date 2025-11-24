import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/download_dll_files_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_states.dart';

class ExcelCubit extends Cubit<ExcelState> {
  final DownloadAllFilesUseCase _downloadAllFilesUseCase;

  ExcelCubit(this._downloadAllFilesUseCase) : super(ExcellInitial());

  Future<void> downloadAllFiles() async {
    emit(ExcellLoadInProgress());

    final result = await _downloadAllFilesUseCase();

    result.fold(
      (failure) {
        emit(ExcellLoadFailure("failure.message"));
      },
      (success) {
        emit(ExcellLoadSuccess(success.data!.first));
      },
    );
  }
}
