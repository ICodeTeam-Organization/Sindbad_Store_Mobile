import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_attribute_product_dart_state.dart';

class AddAttributeProductDartCubit extends Cubit<AddAttributeProductDartState> {
  AddAttributeProductDartCubit() : super(AddAttributeProductDartInitial());

  final List<TextEditingController> keys = [];
  final List<TextEditingController> values = [];

  void addField() {
    emit(AddAttributeProductDartLoading());
    keys.add(TextEditingController());
    values.add(TextEditingController());
    testAdd();
    emit(AddAttributeProductDartSuccess(keys: keys, values: values));
  }

  void removeField(int index) {
    emit(AddAttributeProductDartLoading());
    test(index); // for test
    keys.removeAt(index);
    values.removeAt(index);
    emit(AddAttributeProductDartSuccess(keys: keys, values: values));
  }

  // fun for test
  void test(int index) {
    print(
        "العنصر المراد حذفه: \n الخاصية== ${keys[index].text}\n القيمة ==  ${values[index].text}");
  }

  // fun for test
  void testAdd() {
    print(" ===================  list keys = ${keys.length}");
    print(" ===================  list values = ${values.length}");
  }
}
