import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/confrim_password_parans.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/confirm_password_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/confirm_password_cubit/confrm_passwrd_states.dart';

class ConfirmPasswordCubit extends Cubit<ConfirmPasswordState> {
  final ConfirmPasswordUseCase _confirmPasswordUseCase;
  ConfirmPasswordCubit(this._confirmPasswordUseCase)
      : super(ConfirmPasswordInitial());

  void confirmPassword(
      String codeNo1,
      String codeNo2,
      String codeNo3,
      String codeNo4,
      String codeNo5,
      String codeNo6,
      String phoneNumber) async {
    emit(ConfirmPasswordLoadInProgress());

    String code = codeNo1 + codeNo2 + codeNo3 + codeNo4 + codeNo5 + codeNo6;
    final result = await _confirmPasswordUseCase
        .execute(ConfrimPasswordParans(phoneNumber, code));
    // emit(ConfirmPasswordSuccess());
    result.fold((failure) {
      //emiting error state

      emit(ConfirmPasswordLoadFailure(failure.error));
    }, (dataState) {
      //emiting success state
      emit(ConfirmPasswordSuccess());
    });
  }
}
