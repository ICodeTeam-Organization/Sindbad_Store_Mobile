part of 'notifiction_cubit.dart';

@immutable
sealed class NotifictionState {}

final class NotifictionInitial extends NotifictionState {}

final class NotifictionLoading extends NotifictionState {}

final class NotifictionPagtionLoading extends NotifictionState {}

final class NotiftionPagtionFailure extends NotifictionState {
  final String errorMessage;
  NotiftionPagtionFailure({required this.errorMessage});
}

final class NotifictionSuccess extends NotifictionState {
  final List<NotifctionEntity> notifictionList;
  NotifictionSuccess({required this.notifictionList});
}

final class NotifictionFailure extends NotifictionState {
  final String errorMessage;

  NotifictionFailure({required this.errorMessage});
}
