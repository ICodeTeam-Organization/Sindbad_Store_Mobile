part of 'get_category_cubit.dart';

sealed class GetCategoryState {}

final class GetCategoryInitial extends GetCategoryState {}

final class GetCategoryLoadInProgress extends GetCategoryState {}

final class GetCategoryLoadSuccess extends GetCategoryState {
  final List<StoreCategoryModel> categoryies;

  GetCategoryLoadSuccess(
    this.categoryies,
  );
}

final class GetCategoryLoadFailure extends GetCategoryState {
  final String errMessage;

  GetCategoryLoadFailure(this.errMessage);
}
