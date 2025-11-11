import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/forget_password_params.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/forget_password_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase forgetPasswordUseCase;
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ForgetPasswordCubit(this.forgetPasswordUseCase)
      : super(ForgetPasswordInitial());

  Future<void> foregetPassword(String phone, String password) async {
    //emeting loadng state
    emit(ForgetPasswordLoadInProgress());
    // await Future.delayed(const Duration(seconds: 10));
    var params = ForgetPasswordParams(phone, password);
    final result = await forgetPasswordUseCase.execute(params);

    result.fold((failure) {
      //emiting error state
      emit(ForgetPasswordLoadFailure("an error occurred"));
    }, (dataState) {
      //emiting success state
      emit(ForgetPasswordLoadSuccess());
    });
  }
}
