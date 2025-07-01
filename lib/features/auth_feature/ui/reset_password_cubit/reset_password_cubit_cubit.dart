import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entity/reset_password_entity.dart';
import '../../domain/usecase/reset_password_use_case.dart';

part 'reset_password_cubit_state.dart';

class ResetPasswordCubitCubit extends Cubit<ResetPasswordCubitState> {
  final ResetPasswordUseCase resetPasswordUseCase;
  ResetPasswordCubitCubit(this.resetPasswordUseCase)
      : super(ResetPasswordCubitInitial());

  Future<void> resetPassword(String currentPassword, String newPassword) async {
    emit(ResetPasswordCubitLoading());

    try {
      var params = ResetPasswordParams(currentPassword, newPassword);
      final result = await resetPasswordUseCase.execute(params);

      result.fold(
          // left
          (failure) => emit(ResetPasswordCubitFailure(failure.message)),
          // right
          (userPassword) {
        if (userPassword.isSuccess == true) {
          emit(ResetPasswordCubitSuccess(userPassword));
        }
      });
    } catch (e) {
      // new
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(ResetPasswordCubitFailure(failure.message));
      } else {
        emit(ResetPasswordCubitFailure(e.toString()));
      }
    }
  }
}
