part of 'get_main_category_for_view_cubit.dart';

sealed class GetMainCategoryForViewState {}

final class GetMainCategoryForViewInitial extends GetMainCategoryForViewState {}

final class GetMainCategoryForViewLoading extends GetMainCategoryForViewState {}

final class GetMainCategoryForViewSuccess extends GetMainCategoryForViewState {
  final List<MainCategoryForViewEntity> mainCategoryForViewEntity;
  final bool isLoadingMore; // true when pagination loading is shown

  GetMainCategoryForViewSuccess({
    required this.mainCategoryForViewEntity,
    this.isLoadingMore = false,
  });
}

final class GetMainCategoryForViewFailure extends GetMainCategoryForViewState {
  final String errMessage;

  GetMainCategoryForViewFailure({required this.errMessage});
}

// add states for pagination
final class GetMainCategoryForViewPaginationLoading
    extends GetMainCategoryForViewState {}

final class GetMainCategoryForViewPaginationFailure
    extends GetMainCategoryForViewState {
  final String errMessage;

  GetMainCategoryForViewPaginationFailure({required this.errMessage});
}
