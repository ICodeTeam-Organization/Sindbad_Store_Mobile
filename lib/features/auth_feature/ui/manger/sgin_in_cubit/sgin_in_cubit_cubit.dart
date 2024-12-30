import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';

part 'sgin_in_cubit_state.dart';

class SignInCubitCubit extends Cubit<SignInCubitState> {
  final SignInUseCase signInUseCase;

  SignInCubitCubit(this.signInUseCase) : super(SignInCubitInitial());

  Future<void> signIn(String phone, String password) async {
    emit(SignInCubitLoading());

    try {
      var params = SignInParams(phone, password);
      final result = await signInUseCase.execute(params);

      result.fold(
          // left
          (failure) => emit(SignInCubitFailure(failure.message)),
          // right
          (userData) {
        if (userData.isSuccess == true) {
          emit(SignInCubitSuccess(userData));
        } else {
          emit(SignInCubitFailure(
              'Sorry, Phone Number or The Password is Wrong'));
        }
      });
    } catch (e) {
      // new
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(SignInCubitFailure(failure.message));
      } else {
        emit(SignInCubitFailure(e.toString()));
      }
    }
  }
}
