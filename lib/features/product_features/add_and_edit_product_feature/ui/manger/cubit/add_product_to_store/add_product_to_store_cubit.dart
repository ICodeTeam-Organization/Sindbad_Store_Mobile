import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'add_product_to_store_state.dart';

class AddProductToStoreCubit extends Cubit<AddProductToStoreState> {
  AddProductToStoreCubit() : super(AddProductToStoreInitial());

  // all controller for [ info product ] ==> add product page
  TextEditingController nameProductController = TextEditingController();
  TextEditingController numberProductController = TextEditingController();
  TextEditingController priceProductController = TextEditingController();
  TextEditingController descriptionProductController = TextEditingController();

  // all File for [ product Images ] ==> add product page
  String? mainImageProduct;
  String? subOneImageProduct;
  String? subTwoImageProduct;
  String? subThreeImageProduct;

  // all num for [ Type product ] ==> add product page
  int? selectedMainCategoryId;
  int? selectedSubCategoryId;
  int? selectedBrandId;
  void testDropDown() {
    print("=======================  testDropDown  =====================");
    print("تم اختيار الفئة الرئيسية: ID = $selectedMainCategoryId");
    print("تم اختيار الفئة الفرعية: ID = $selectedSubCategoryId");
    print("تم اختيار البراند: ID = $selectedBrandId");
    print("=======================  testDropDown  =====================");
  }

  // all fileds for [ Attribute product ] ==> add product page
  List<TextEditingController> keys = [];
  List<TextEditingController> values = [];

  // for test Post Request
  void testPostRequest() {
    print("=======================  testPostRequest  =====================");
    print("nameProduct =>                  ${nameProductController.text}");
    print("numberProduct =>                ${numberProductController.text}");
    print("priceProduct =>                 ${priceProductController.text}");
    print(
        "descriptionProduct =>           ${descriptionProductController.text}");
    print("mainImageProduct =>             $mainImageProduct");
    print("subOneImageProduct =>           $subOneImageProduct");
    print("subTwoImageProduct =>           $subTwoImageProduct");
    print("subThreeImageProduct =>         $subThreeImageProduct");
    print("MainCategoryId =>               $selectedMainCategoryId");
    print("SubCategoryId =>                $selectedSubCategoryId");
    print("BrandId =>                      $selectedBrandId");
    for (int i = 0; i < keys.length; i++) {
      print("key $i+1 =>                      ${keys[i].text}");
      print("value $i+1 =>                    ${values[i].text}");
    }
    print("=======================  testPostRequest  =====================");
  }
}
