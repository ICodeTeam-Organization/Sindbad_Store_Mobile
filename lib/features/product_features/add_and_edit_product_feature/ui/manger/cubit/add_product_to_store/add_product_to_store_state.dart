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

// // for Add Image
// // final class AddImageProductToStoreInitial extends AddProductToStoreState {}
// final class AddImageProductToStoreSuccess extends AddProductToStoreState {}

// // for drop down
// final class GetCategoryNamesLoading extends AddProductToStoreState {}

// final class GetCategoryNamesSuccess extends AddProductToStoreState {
//   final Map<int, Map<String, List<Map<String, dynamic>>>>
//       categoryAndSubCategoryNames;

//   GetCategoryNamesSuccess({required this.categoryAndSubCategoryNames});
// }

// final class GetCategoryNamesFailure extends AddProductToStoreState {}

// final class GetSubCategoryNamesSuccess
//     extends AddProductToStoreState {} // for SubCategoryNames only
