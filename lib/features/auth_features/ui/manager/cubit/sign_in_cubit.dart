import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../../core/errors/failure.dart';
import '../../../domain/entities/sign_in_entity.dart';
import '../../../domain/usecases/sign_in_usecase.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final SignInUseCase signInUseCase;
  SignInCubit(this.signInUseCase) : super(SignInInitial());
  Future<void> signIn(String phone, String password) async {
    emit(SignInLoading());

    try {
      var params = SignInParams(phone, password);
      final result = await signInUseCase.execute(params);

      result.fold(
          // left
          (failure) => emit(SignInFailure(failure.message)),
          // right
          (userData) {
        if (userData.isSuccess == true) {
          emit(SignInSuccess(userData));
        } else {
          emit(SignInFailure('Sorry, Phone Number or The Password is Wrong'));
        }
      });
    } catch (e) {
      // new
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(SignInFailure(failure.message));
      } else {
        emit(SignInFailure(e.toString()));
      }
    }
  }
}
