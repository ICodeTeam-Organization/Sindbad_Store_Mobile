import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../manger/cubit/attribute_product/attribute_product_cubit.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';

class TwoButtonInDownAddProduct extends StatelessWidget {
  final AddProductToStoreCubit cubitAddProduct;

  final VoidCallback? onSuccessCallback;
  const TwoButtonInDownAddProduct({
    super.key,
    this.onSuccessCallback,
    required this.cubitAddProduct,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ============  Done button  ================
        BlocConsumer<AddProductToStoreCubit, AddProductToStoreState>(
          listener: (context, state) {
            if (state is AddProductToStoreSuccess) {
              // Trigger the callback to refresh parent screen
              if (onSuccessCallback != null) {
                onSuccessCallback!();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'تم إضافة المنتج بنجاح!',
                )),
              );
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return StorePrimaryButton(
              isLoading: state is AddProductToStoreLoading,
              onTap: () async {
                cubitAddProduct.keys = context
                    .read<AttributeProductCubit>()
                    .state
                    .keys; //  important before test
                cubitAddProduct.values = context
                    .read<AttributeProductCubit>()
                    .state
                    .values; //  important before test
                await cubitAddProduct.addProductToStore();
              },
              title: "تأكيد",
              width: 200.w,
              height: 50.h,
              buttonColor: AppColors.primary,
            );
          },
        ),
        SizedBox(width: 8.w),
        // ============  Cancel button  ================
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
