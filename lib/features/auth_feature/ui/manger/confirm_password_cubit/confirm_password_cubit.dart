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
    await Future.delayed(Duration(seconds: 10));

    // if (codeNo1.isNotEmpty ||
    //     codeNo2.isNotEmpty ||
    //     codeNo3.isNotEmpty ||
    //     codeNo4.isNotEmpty ||
    //     codeNo5.isNotEmpty ||
    //     codeNo6.isNotEmpty) {
    String code = codeNo1 + codeNo2 + codeNo3 + codeNo4 + codeNo5 + codeNo6;
    final result = await _confirmPasswordUseCase
        .execute(ConfrimPasswordParans(code, phoneNumber));
    emit(ConfirmPasswordSuccess());
    // result.fold((failure) {
    //   //emiting error state
    //   emit(ConfirmPasswordLoadFailure("an error occurred"));
    // }, (dataState) {
    //   //emiting success state
    //   emit(ConfirmPasswordSuccess());
    // });
    // }
  }
}
