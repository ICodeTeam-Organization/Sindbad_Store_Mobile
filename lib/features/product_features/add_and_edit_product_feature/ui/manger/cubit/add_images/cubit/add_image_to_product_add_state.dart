part of 'add_image_to_product_add_cubit.dart';

@immutable
sealed class AddImageToProductAddState {}

final class AddImageToProductAddInitial extends AddImageToProductAddState {}

// for Add Image
// final class AddImageProductToStoreInitial extends AddProductToStoreState {}
final class AddImageToProductAddSuccess extends AddImageToProductAddState {}
