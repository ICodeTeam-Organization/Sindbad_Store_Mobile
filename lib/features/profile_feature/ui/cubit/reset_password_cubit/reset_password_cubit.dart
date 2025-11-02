import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/reset_password_params.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../auth_feature/domain/entity/reset_password_entity.dart';
import '../../../../auth_feature/domain/usecase/reset_password_use_case.dart';

part 'reset_password_cubit_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  ResetPasswordCubit(this.resetPasswordUseCase) : super(ResetPasswordInitial());

  Future<void> resetPassword(String currentPassword, String newPassword) async {
    emit(ResetPasswordLoadInProgress());

    try {
      var params = ResetPasswordParams(currentPassword, newPassword);
      final result = await resetPasswordUseCase.execute(params);

      result.fold(
          // left
          (failure) => emit(ResetPasswordLoadFailure(failure.message)),
          // right
          (userPassword) {
        if (userPassword.isSuccess == true) {
          emit(ResetPasswordLoadSuccess(userPassword));
        }
      });
    } catch (e) {
      // new
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(ResetPasswordLoadFailure(failure.message));
      } else {
        emit(ResetPasswordLoadFailure(e.toString()));
      }
    }
  }
}
