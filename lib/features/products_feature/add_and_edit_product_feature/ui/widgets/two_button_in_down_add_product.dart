import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import '../../../../../config/styles/Colors.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';

class TwoButtonInDownAddProduct extends StatelessWidget {
//  final AddProductToStoreCubit cubitAddProduct;
  final VoidCallback? onSuccessCallback;
  final List<String> tags;
  final String shortDescription;
  final num oldPrice;
  const TwoButtonInDownAddProduct({
    super.key,
    this.onSuccessCallback,
    //  required this.cubitAddProduct,
    required this.tags,
    required this.shortDescription,
    required this.oldPrice,
  });

  bool validateFields(
      BuildContext context, AddProductToStoreCubit cubitAddProduct) {
    if (cubitAddProduct.nameProductController.text.isEmpty ||
        cubitAddProduct.priceProductController.text.isEmpty ||
        cubitAddProduct.numberProductController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء تعبئة كافة الحقول المطلوبة')),
      );
      return false;
    }

    if (cubitAddProduct.mainImageProductFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء اختيار الصورة الرئيسية للمنتج')),
      );
      return false;
    }

    if (cubitAddProduct.selectedMainCategoryId == null ||
        cubitAddProduct.selectedSubCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('برجاء اختيار نوع المنتج بشكل صحيح')),
      );
      return false;
    }

    // if (cubitAddProduct.selectedBrandId == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('برجاء اختيار علامة تجارية أو اختيار "لايوجد"')),
    //   );
    //   return false;
    // }

    bool attributesValid = true;
    for (int i = 0; i < cubitAddProduct.keys.length; i++) {
      if (cubitAddProduct.keys[i].text.isEmpty ||
          cubitAddProduct.values[i].text.isEmpty) {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocConsumer<AddProductToStoreCubit, AddProductToStoreState>(
          listener: (context, state) {
            if (state is AddProductToStoreSuccess) {
              if (onSuccessCallback != null) {
                onSuccessCallback!();
              }
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم إضافة المنتج بنجاح!')),
              );
            }
            if (state is AddProductToStoreFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text('فشل في إضافة المنتج, الرجاء المحاولة مرة أخرى')),
              );
            }
          },
          builder: (context, state) {
            return StorePrimaryButton(
              isLoading: state is AddProductToStoreLoading,
              onTap: () async {
                // if (validateFields(context, cubitAddProduct)) {
                //   cubitAddProduct.keys =
                //       context.read<AttributeProductCubit>().state.keys;
                //   cubitAddProduct.values =
                //       context.read<AttributeProductCubit>().state.values;
                //   await cubitAddProduct.addProductToStore(
                //     tags,
                //     shortDescription,
                //     oldPrice,
                //   );
                // }
              },
              title: "تأكيد",
              width: 200.w,
              height: 50.h,
              buttonColor: AppColors.primary,
            );
          },
        ),
        SizedBox(width: 8.w),
        StorePrimaryButton(
          onTap: () => Navigator.of(context).pop(),
          title: "إلغاء",
          width: 100.w,
          height: 50.h,
          buttonColor: AppColors.greyIcon,
        ),
      ],
    );
  }
}
