import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domin/entity/get_profile_data_entity.dart';
import '../../../domin/usecase/get_profile_data_usecase.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  final GetProfileDataUsecase getProfileDataUsecase;
  GetProfileCubit(this.getProfileDataUsecase) : super(GetProfileInitial());

  Future<void> getProfile() async {
    emit(GetProfileLoadInProgress());
    final result = await getProfileDataUsecase.execute();
    result.fold((failure) {
      emit(GetProfileLoadFailure(failure.message));
    }, (getProfileDataEntity) {
      emit(GetProfileLoadSuccess(getProfileDataEntity));
    });
  }
}
