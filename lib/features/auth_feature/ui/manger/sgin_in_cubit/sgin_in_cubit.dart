import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/utils/currancy.dart';
import 'package:sindbad_management_app/core/utils/key_name.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/sign_in_entity.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/entity/singin_params.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit_state.dart';

class SignInCubit extends Cubit<SigninState> {
  final SignInUseCase signInUseCase;
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  SignInCubit(this.signInUseCase) : super(SigninInitial());

  Future<void> signIn(String phone, String password) async {
    //emeting loadng state
    emit(SigninLoadInProgress());

    try {
      var params = SignInParams(phone, password);
      final result = await signInUseCase.execute(params);

      result.fold(
          // left
          (failure) => emit(SigninLoadFailure(failure.message)),
          // right
          (userData) {
        if (userData.isSuccess == true) {
          if (userData.userRoles[0] == "Store") {
            secureStorage.write(
                key: KeyName.country, value: userData.userCuntry);
            Currancy.initCurrency();
            emit(SigninCubitSuccess());
          } else {
            emit(SigninLoadFailure("ليس لديك الصلاحيه لاستخدم هذا التطبيق"));
          }
        } else {
          emit(SigninLoadFailure('عفوا, رقم الهاتف او كلمة المرور غير صحيحة'));
        }
      });
    } catch (e) {
      // new
      if (e is DioException) {
        ServerFailure failure = ServerFailure.fromDioError(e);
        emit(SigninLoadFailure(failure.message));
      } else {
        emit(SigninLoadFailure(e.toString()));
      }
    }
  }
}
