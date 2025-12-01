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




// sealed class WeatherState {
//   const WeatherState();
// }

// final class WeatherInitial extends WeatherState {
//   const WeatherInitial();
// }

// final class WeatherLoadInProgress extends WeatherState {
//   const WeatherLoadInProgress();
// }

// final class WeatherLoadSuccess extends WeatherState {
//   const WeatherLoadSuccess({required this.weather});
//   final Weather weather;
// }

// final class WeatherLoadFailure extends WeatherState {
//   const WeatherLoadFailure({required this.exception});
//   final Exception exception;
// }