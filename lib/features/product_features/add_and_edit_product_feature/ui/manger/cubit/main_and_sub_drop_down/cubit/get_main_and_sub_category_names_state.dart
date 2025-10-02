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

final class GetCategoryNamesPaganiationLoading extends GetCategoryNamesState {}

final class GetCategoryNamesPaganiationFailer extends GetCategoryNamesState {
  final String errMessage;

  GetCategoryNamesPaganiationFailer({required this.errMessage});
}

final class UpdateSubCategoryState extends GetCategoryNamesState {
  final bool seleted;
  final List<CategoryEntity> subCategories;
  UpdateSubCategoryState({required this.subCategories, required this.seleted});
}
