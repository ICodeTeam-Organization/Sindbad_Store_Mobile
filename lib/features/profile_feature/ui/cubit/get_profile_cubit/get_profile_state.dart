part of 'get_profile_cubit.dart';

@immutable
sealed class GetProfileState {}

final class GetProfileInitial extends GetProfileState {}

class GetProfileLoadInProgress extends GetProfileState {}

class GetProfileLoadSuccess extends GetProfileState {
  final GetProfileDataEntity? profileModel;
  GetProfileLoadSuccess(this.profileModel);
}

class GetProfileLoadFailure extends GetProfileState {
  final String error;
  GetProfileLoadFailure(this.error);
}


/// --- IGNORE ---
/// sealed class CounterState {}
// final class CounterInitial extends CounterState {}
// final class CounterLoadInProgress extends CounterState {}
// final class CounterLoadSuccess extends CounterState {}
// final class CounterLoadFailure extends CounterState {}