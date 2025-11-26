import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';

import '../manger/cubit/attribute_product/attribute_product_cubit.dart';

class TwoButtonInDownForEditProduct extends StatelessWidget {
  const TwoButtonInDownForEditProduct({
    super.key,
    required this.cubitEditProduct,
    required this.idProduct,
    required TextEditingController priceProductController,
    required TextEditingController descriptionProductController,
    required this.cubitAttribute,
    required this.oldPriceController,
    required this.shortDescriptionProductController,
    required this.tags,
    this.onSuccessCallback,
  })  : _priceProductController = priceProductController,
        _descriptionProductController = descriptionProductController;

  final EditProductFromStoreCubit cubitEditProduct;
  final int idProduct;
  final VoidCallback? onSuccessCallback;
  final TextEditingController _priceProductController;
  final TextEditingController _descriptionProductController;
  final AttributeProductCubit cubitAttribute;
  final TextEditingController? oldPriceController;
  final TextEditingController? shortDescriptionProductController;
  final List<String>? tags;

  bool validateFields(
      BuildContext context, EditProductFromStoreCubit cubitEditProduct) {
    if (_priceProductController.text.isEmpty ||
        _descriptionProductController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء تعبئة كافة الحقول المطلوبة')),
      );
      return false;
    }

    // if (cubitEditProduct.mainImageProductFile == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('برجاء اختيار الصورة الرئيسية للمنتج')),
    //   );
    //   return false;
    // }

    if (cubitEditProduct.subOneImageProductFile == null &&
        cubitEditProduct.subTwoImageProductFile == null &&
        cubitEditProduct.subThreeImageProductFile == null &&
        cubitEditProduct.subOneImageProductUrl == null &&
        cubitEditProduct.subTwoImageProductUrl == null &&
        cubitEditProduct.subThreeImageProductUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء اختيار صورة فرعية على الأقل للمنتج')),
      );
      return false;
    }

    if (cubitEditProduct.selectedMainCategoryId == null ||
        cubitEditProduct.selectedSubCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء اختيار نوع المنتج بشكل صحيح')),
      );
      return false;
    }

    bool attributesValid = true;
    for (int i = 0; i < cubitAttribute.state.keys.length; i++) {
      if (cubitAttribute.state.keys[i].text.isEmpty ||
          cubitAttribute.state.values[i].text.isEmpty) {
        attributesValid = false;
        break;
      }
    }
    if (!attributesValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء تعبئة كافة خصائص المنتج')),
      );
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocConsumer<EditProductFromStoreCubit, EditProductFromStoreState>(
            listener: (context, state) {
              if (state is EditProductFromStoreSuccess) {
                if (onSuccessCallback != null) {
                  onSuccessCallback!(); // refresh product list
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تم تعديل المنتج بنجاح!')),
                );
                Navigator.of(context).pop(); // close Edit product
              } else if (state is EditProductFromStoreFailure) {
                debugPrint(state.errMessage);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errMessage)),
                );
              }
            },
            builder: (context, state) {
              return StorePrimaryButton(
                isLoading: state is EditProductFromStoreLoading,
                title: "تأكيد",
                width: 200.w,
                height: 50.h,
                buttonColor: AppColors.primary,
                onTap: () async {
                  if (validateFields(context, cubitEditProduct)) {
                    await cubitEditProduct.editProductFromStore(
                      productId: idProduct,
                      priceProductController: _priceProductController,
                      descriptionProductController:
                          _descriptionProductController,
                      keys: cubitAttribute.state.keys,
                      values: cubitAttribute.state.values,
                      oldPriceController: oldPriceController,
                      shortDescriptionProductController:
                          shortDescriptionProductController,
                      tags: tags ?? [], // ensure tags is not null
                    );
                  }
                },
              );
            },
          ),
          SizedBox(width: 8.w),
          StorePrimaryButton(
            onTap: () => Navigator.of(context).pop(), // close Edit product
            title: "إلغاء",
            width: 100.w,
            height: 50.h,
            buttonColor: AppColors.greyIcon,
          ),
        ],
      ),
    );
  }
}
