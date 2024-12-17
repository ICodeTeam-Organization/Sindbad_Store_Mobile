part of 'add_attribute_product_dart_cubit.dart';

sealed class AddAttributeProductDartState {}

final class AddAttributeProductDartInitial
    extends AddAttributeProductDartState {}

final class AddAttributeProductDartLoading
    extends AddAttributeProductDartState {}

final class AddAttributeProductDartSuccess
    extends AddAttributeProductDartState {
  final List<TextEditingController> keys;
  final List<TextEditingController> values;

  AddAttributeProductDartSuccess({required this.keys, required this.values});
}

// final class AddAttributeProductDartFailure
//     extends AddAttributeProductDartState {}
