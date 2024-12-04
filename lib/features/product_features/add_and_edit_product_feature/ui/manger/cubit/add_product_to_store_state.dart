part of 'add_product_to_store_cubit.dart';

@immutable
sealed class AddProductToStoreState {}

//
final class AddProductToStoreInitial extends AddProductToStoreState {}

final class AddProductToStoreLoading extends AddProductToStoreState {}

final class AddProductToStoreSuccess extends AddProductToStoreState {}

final class AddProductToStoreFailure extends AddProductToStoreState {}

// for Add Image
// final class AddImageProductToStoreInitial extends AddProductToStoreState {}
final class AddImageProductToStoreSuccess extends AddProductToStoreState {}
