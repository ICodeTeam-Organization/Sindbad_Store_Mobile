part of 'refresh_page_cubit.dart';

@immutable
sealed class RefreshPageState {}

final class RefreshPageInitial extends RefreshPageState {}

final class ChangeVisibiltyButtonsState extends RefreshPageState {
  ChangeVisibiltyButtonsState();
}
