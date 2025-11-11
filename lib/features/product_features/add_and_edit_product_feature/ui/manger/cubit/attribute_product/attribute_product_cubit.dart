import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttributeProductCubit extends Cubit<AttributeProduct> {
  AttributeProductCubit() : super(AttributeProduct(keys: [], values: []));

  void addField() {
    emit(AttributeProduct(
      keys: List.from(state.keys)..add(TextEditingController()),
      values: List.from(state.values)..add(TextEditingController()),
    ));
  }

  void removeField(int index) {
    emit(AttributeProduct(
      keys: List.from(state.keys)..removeAt(index),
      values: List.from(state.values)..removeAt(index),
    ));
  }

  // for edit page
  void initialField({
    required List<String> textKeys,
    required List<String> textValues,
  }) {
    emit(AttributeProduct(
      keys: textKeys.map((text) => TextEditingController(text: text)).toList(),
      values:
          textValues.map((text) => TextEditingController(text: text)).toList(),
    ));
  }
}

class AttributeProduct {
  final List<TextEditingController> keys;
  final List<TextEditingController> values;

  AttributeProduct({
    required this.keys,
    required this.values,
  });
}
