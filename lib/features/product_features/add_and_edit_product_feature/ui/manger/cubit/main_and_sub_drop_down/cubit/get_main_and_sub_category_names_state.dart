part of 'get_main_and_sub_category_names_cubit.dart';

@immutable
sealed class GetCategoryNamesState {}

// for drop down
final class GetCategoryNamesInitial extends GetCategoryNamesState {}

final class GetCategoryNamesLoading extends GetCategoryNamesState {}

final class GetCategoryNamesSuccess extends GetCategoryNamesState {
  final List<CategoryEntity> categoryAndSubCategoryNames;

  GetCategoryNamesSuccess({required this.categoryAndSubCategoryNames});
}

final class GetCategoryNamesFailure extends GetCategoryNamesState {
  final String errMessage;

  GetCategoryNamesFailure({required this.errMessage});
}
