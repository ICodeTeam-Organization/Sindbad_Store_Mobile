part of 'get_main_and_sub_category_names_cubit.dart';

@immutable
sealed class GetCategoryNamesState {}

final class GetCategoryNamesInitial extends GetCategoryNamesState {}

// for drop down
final class GetCategoryNamesLoading extends GetCategoryNamesState {}

final class GetCategoryNamesSuccess extends GetCategoryNamesState {
  final Map<int, Map<String, List<Map<String, dynamic>>>>
      categoryAndSubCategoryNames;

  GetCategoryNamesSuccess({required this.categoryAndSubCategoryNames});
}

final class GetCategoryNamesFailure extends GetCategoryNamesState {}

final class GetCategoryNamesMainCategoryUpdated
    extends GetCategoryNamesState {} // for SubCategoryNames only
