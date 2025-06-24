part of 'unread_notifiction_cubit.dart';

@immutable
sealed class UnreadNotifictionState {}

final class UnreadNotifictionInitial extends UnreadNotifictionState {}

final class UnreadNotifictionLoading extends UnreadNotifictionState {}

final class UnreadNotifictionSuccess extends UnreadNotifictionState {
  final GetUnreadNutficonEntity getUnreadNotifiction;
  UnreadNotifictionSuccess(this.getUnreadNotifiction);
}

final class UnreadNotifictionFailure extends UnreadNotifictionState {
  final String failure;
  UnreadNotifictionFailure(this.failure);
}
