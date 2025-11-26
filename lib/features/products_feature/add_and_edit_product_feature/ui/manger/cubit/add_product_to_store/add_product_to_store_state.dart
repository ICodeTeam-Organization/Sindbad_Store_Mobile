part of 'add_product_to_store_cubit.dart';

@immutable
sealed class AddProductToStoreState {}

//
final class AddProductToStoreInitial extends AddProductToStoreState {}

final class AddProductToStoreLoading extends AddProductToStoreState {}

final class AddProductToStoreSuccess extends AddProductToStoreState {
  final AddProductEntity message;

  AddProductToStoreSuccess({required this.message});
}

final class AddProductToStoreFailure extends AddProductToStoreState {
  final String errMessage;

  AddProductToStoreFailure({required this.errMessage});
}
