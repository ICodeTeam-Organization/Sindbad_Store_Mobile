import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';

class TwoButtonInDownForEditProduct extends StatelessWidget {
  const TwoButtonInDownForEditProduct({
    super.key,
    required this.cubitEditProduct,
    required this.idProduct,
    required TextEditingController priceProductController,
    required TextEditingController descriptionProductController,
    required this.cubitAttribute,
  })  : _priceProductController = priceProductController,
        _descriptionProductController = descriptionProductController;

  final EditProductFromStoreCubit cubitEditProduct;
  final int idProduct;
  final TextEditingController _priceProductController;
  final TextEditingController _descriptionProductController;
  final AddAttributeProductDartCubit cubitAttribute;

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
                  await cubitEditProduct.editProductFromStore(
                    productId: idProduct,
                    priceProductController: _priceProductController,
                    descriptionProductController: _descriptionProductController,
                    keys: cubitAttribute.keys,
                    values: cubitAttribute.values,
                  );
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
