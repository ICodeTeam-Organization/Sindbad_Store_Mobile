part of 'get_main_category_for_view_cubit.dart';

sealed class GetMainCategoryForViewState {}

final class GetMainCategoryForViewInitial extends GetMainCategoryForViewState {}

final class GetMainCategoryForViewLoading extends GetMainCategoryForViewState {}

final class GetMainCategoryForViewSuccess extends GetMainCategoryForViewState {
  final List<MainCategoryForViewEntity> mainCategoryForViewEntity;

  GetMainCategoryForViewSuccess({required this.mainCategoryForViewEntity});
}

final class GetMainCategoryForViewFailure extends GetMainCategoryForViewState {
  final String errMessage;

  GetMainCategoryForViewFailure({required this.errMessage});
}
