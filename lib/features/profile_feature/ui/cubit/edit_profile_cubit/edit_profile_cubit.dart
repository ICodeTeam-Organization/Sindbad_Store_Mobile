import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domin/entity/edit_profile_entity.dart';
import '../../../domin/usecase/edit_profile_usecase.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final EditProfileUsecase editProfileUsecase;
  EditProfileCubit(this.editProfileUsecase) : super(EditProfileInitial());

  Future<void> editProfile(
      String name, String email, String phone, String telePhone) async {
    emit(EditProfileLoading());
    final params = UpdateProfileParams(
      name: name,
      email: email,
      phone: phone,
      telphon: telePhone,
    );
    final result = await editProfileUsecase.execute(params);
    result.fold((failure) => emit(EditProfileFailure(failure.message)),
        (editProfileEntity) => emit(EditProfileSuccess(editProfileEntity)));
  }
}
