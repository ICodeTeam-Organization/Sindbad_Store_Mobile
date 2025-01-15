import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/edit_product_from_store_use_case.dart';
part 'edit_product_from_store_state.dart';

class EditProductFromStoreCubit extends Cubit<EditProductFromStoreState> {
  final EditProductFromStoreUseCase editProductFromStoreUseCase;

  EditProductFromStoreCubit(this.editProductFromStoreUseCase)
      : super(EditProductFromStoreInitial());

  // // all controller for [ info product ] ==> add product page
  // TextEditingController nameProductController = TextEditingController();
  // TextEditingController numberProductController = TextEditingController();
  // TextEditingController priceProductController = TextEditingController();
  // TextEditingController descriptionProductController = TextEditingController();

  // // all File for [ product Images ] ==> add product page
  // String? mainImageProduct;
  // String? subOneImageProduct;
  // String? subTwoImageProduct;
  // String? subThreeImageProduct;
  // // all File for [ product Images ] ==> add product page
  File? mainImageProductFile;
  File? subOneImageProductFile;
  File? subTwoImageProductFile;
  File? subThreeImageProductFile;

  // // all num for [ Type product ] ==> add product page
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

  // // all fileds for [ Attribute product ] ==> add product page
  // List<TextEditingController> keys = [];
  // List<TextEditingController> values = [];

  // // for test Post Requeste
  // void testPostRequest() {
  //   print("=======================  testPostRequest  =====================");
  //   print("nameProduct =>                  ${nameProductController.text}");
  //   print("numberProduct =>                ${numberProductController.text}");
  //   print("priceProduct =>                 ${priceProductController.text}");
  //   print(
  //       "descriptionProduct =>           ${descriptionProductController.text}");
  //   print(
  //       "mainImageProduct =>             ${path.basename(mainImageProductFile?.path ?? 'لايوجد')}");
  //   print(
  //       "subOneImageProduct =>           ${path.basename(subOneImageProductFile?.path ?? 'لايوجد')}");
  //   print(
  //       "subTwoImageProduct =>           ${path.basename(subTwoImageProductFile?.path ?? 'لايوجد')}");
  //   print(
  //       "subThreeImageProduct =>         ${path.basename(subThreeImageProductFile?.path ?? 'لايوجد')}");
  //   print("MainCategoryId =>               $selectedMainCategoryId");
  //   print("SubCategoryId =>                $selectedSubCategoryId");
  //   print("BrandId =>                      $selectedBrandId");
  //   for (int i = 0; i < keys.length; i++) {
  //     print("key ${i + 1} =>                        ${keys[i].text}");
  //     print("value ${i + 1} =>                      ${values[i].text}");
  //   }
  //   print([
  //     for (int i = 0; i < keys.length; i++)
  //       {"attributeName": keys[i].text, "attributeValue": values[i].text}
  //   ]);
  //   print("=======================  testPostRequest  =====================");
  // }

  // void addProductToStore() async {
  //   emit(AddProductToStoreLoading()); // ======== emit ==========
  //   print("===========  جاررررررررررررري التحميييييل  =========");
  //   AddProductToStoreParams params = AddProductToStoreParams(
  //     name: nameProductController.text,
  //     price: num.parse(priceProductController.text),
  //     description: descriptionProductController.text,
  //     mainImageFile: mainImageProductFile!,
  //     number: numberProductController.text,
  //     storeId: null,
  //     offerId: null,
  //     brandId: selectedBrandId,
  //     mainCategoryId: selectedMainCategoryId!,
  //     images: [
  //       if (subOneImageProductFile != null) subOneImageProductFile!,
  //       if (subTwoImageProductFile != null) subTwoImageProductFile!,
  //       if (subThreeImageProductFile != null) subThreeImageProductFile!,
  //     ],
  //     subCategoryIds: [selectedSubCategoryId!],
  //     newAttributes: [
  //       for (int i = 0; i < keys.length; i++)
  //         {"attributeName": keys[i].text, "attributeValue": values[i].text}
  //     ],
  //   );
  //   print("============================  in cubit  ==========================");
  //   Either<Failure, AddProductEntity> result =
  //       await addProductToStoreUseCase.execute(params);

  //   result.fold(
  //       // left
  //       (failure) {
  //     print("===========  فشششششششششل التحميييييل  =========");
  //     print("===========  ${failure.message} =========");
  //     print("===========  فشششششششششل التحميييييل  =========");
  //     emit(AddProductToStoreFailure(
  //         errMessage: failure.message)); // ======== emit ==========
  //   },
  //       // right
  //       (message) {
  //     print("===========  تمت الإضافة بنجاح =========");
  //     print("=========== success =>  ${message.success} =========");
  //     print("=========== message =>  ${message.message} =========");
  //     print("===========  تمت الإضافة بنجاح =========");
  //     emit(AddProductToStoreSuccess(
  //         message: message)); // ======== emit ==========
  //   });
  // }
}
