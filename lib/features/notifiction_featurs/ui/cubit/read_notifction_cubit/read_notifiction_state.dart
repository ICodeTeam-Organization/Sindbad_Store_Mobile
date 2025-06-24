part of 'read_notifiction_cubit.dart';

@immutable
sealed class ReadNotifictionState {}

final class ReadNotifictionInitial extends ReadNotifictionState {}

final class ReadNotiftionLoading extends ReadNotifictionState {}

final class ReadNotifictionSuccess extends ReadNotifictionState {
  final ReadNotifictonEntity notifictionList;

  ReadNotifictionSuccess({required this.notifictionList});
}

final class ReadNotifictionFailure extends ReadNotifictionState {
  final String errorMessage;
  ReadNotifictionFailure({required this.errorMessage});
}
