import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_attribute_product_dart_state.dart';

class AddAttributeProductDartCubit extends Cubit<AddAttributeProductDartState> {
  AddAttributeProductDartCubit() : super(AddAttributeProductDartInitial());

  final List<TextEditingController> keys = [];
  final List<TextEditingController> values = [];

  void addField() {
    keys.add(TextEditingController());
    values.add(TextEditingController());
    emit(AddAttributeProductDartSuccess(keys: keys, values: values));
  }

  void removeField(int index) {
    keys.removeAt(index);
    values.removeAt(index);
    emit(AddAttributeProductDartSuccess(keys: keys, values: values));
  }
}
