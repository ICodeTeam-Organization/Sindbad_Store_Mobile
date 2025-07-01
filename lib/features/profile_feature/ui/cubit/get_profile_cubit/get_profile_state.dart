part of 'get_profile_cubit.dart';

@immutable
sealed class GetProfileState {}

final class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileSuccess extends GetProfileState {
  final GetProfileDataEntity profileModel;
  GetProfileSuccess(this.profileModel);
}

class GetProfileFailure extends GetProfileState {
  final String error;
  GetProfileFailure(this.error);
}
