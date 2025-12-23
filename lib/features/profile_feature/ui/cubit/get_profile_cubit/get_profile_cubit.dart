import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/logout_use_case.dart';

import '../../../domin/entity/get_profile_data_entity.dart';
import '../../../domin/usecase/get_profile_data_usecase.dart';

part 'get_profile_state.dart';

class ProfileCubit extends Cubit<GetProfileState> {
  final GetProfileDataUsecase getProfileDataUsecase;
  final LogoutUseCase _logoutUseCase;
  ProfileCubit(this.getProfileDataUsecase, this._logoutUseCase)
      : super(GetProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoadInProgress());
    // await Future.delayed(Duration(seconds: 3));
    final result = await getProfileDataUsecase.execute();
    result.fold((failure) {
      emit(GetProfileLoadFailure(failure.message));
    }, (getProfileDataEntity) {
      emit(GetProfileLoadSuccess(getProfileDataEntity));
    });
  }

  Future<void> logout() async {
    emit(GetProfileLoadInProgress());
    var result = await _logoutUseCase.execute();
    result.fold((failure) {
      emit(GetProfileLoadFailure(failure.message!));
    }, (getProfileDataEntity) {
      emit(GetProfileLoadSuccess(null));
    });
    // if (context.mounted) {
    //   Navigator.pop(context);
    //   GoRouter.of(context).go(AppRoutes.signIn);
    //   }
    //  emit(GetProfileLoadInProgress());
    // await Future.delayed(Duration(seconds: 3));
    // final result = await getProfileDataUsecase.execute();
    // result.fold((failure) {
    //   emit(GetProfileLoadFailure(failure.message));
    // }, (getProfileDataEntity) {
    //   emit(GetProfileLoadSuccess(getProfileDataEntity));
    // });
  }
}
