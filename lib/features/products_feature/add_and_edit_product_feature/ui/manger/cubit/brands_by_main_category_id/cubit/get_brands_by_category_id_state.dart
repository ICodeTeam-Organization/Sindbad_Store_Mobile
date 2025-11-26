part of 'get_brands_by_category_id_cubit.dart';

@immutable
sealed class GetBrandsByCategoryIdState {}

final class GetBrandsByCategoryIdInitial extends GetBrandsByCategoryIdState {}

final class GetBrandsByCategoryIdLoading extends GetBrandsByCategoryIdState {}

final class GetBrandsByCategoryIdSuccess extends GetBrandsByCategoryIdState {
  final List<BrandEntity> brands;

  GetBrandsByCategoryIdSuccess({required this.brands});
}

final class GetBrandsByCategoryIdFailure extends GetBrandsByCategoryIdState {}
