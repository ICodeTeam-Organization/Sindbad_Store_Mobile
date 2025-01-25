import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';

import '../../../../../core/styles/Colors.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';

class TwoButtonInDownAddproduct extends StatelessWidget {
  final VoidCallback? onSuccessCallback;
  const TwoButtonInDownAddproduct({
    super.key,
    this.onSuccessCallback,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductToStoreCubit cubitAddProduct =
        context.read<AddProductToStoreCubit>();
    final AddAttributeProductDartCubit cubitAddAttribute =
        context.read<AddAttributeProductDartCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ============  Done button  ================
        BlocConsumer<AddProductToStoreCubit, AddProductToStoreState>(
          listener: (context, state) {
            if (state is AddProductToStoreSuccess) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                  'تم إضافة المنتج بنجاح!',
                  // style: KTextStyle.textStyle16,
                )),
              );
              // Trigger the callback to refresh parent screen
              if (onSuccessCallback != null) {
                onSuccessCallback!();
              }
            }
          },
          builder: (context, state) {
            debugPrint("===========  $state  ========");
            return StorePrimaryButton(
              isLoading: state is AddProductToStoreLoading,
              onTap: () {
                cubitAddProduct.keys =
                    cubitAddAttribute.keys; // == important befor test
                cubitAddProduct.values =
                    cubitAddAttribute.values; // == important befor test
                cubitAddProduct.addProductToStore();
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
          // onTap: () => Navigator.of(context).pop(),
          onTap: () {
            context.go(AppRouter.storeRouters.root);
            // cubitRefrechViewProduct.getStoreProductsWitheFilter(
            //   storeProductsFilter: 0,
            //   pageNumper: 1,
            //   pageSize: 100,
            // );
            // Trigger the callback to refresh parent screen
            // if (onSuccessCallback != null) {
            //   onSuccessCallback!();
            // }
            // Navigator.of(context).pop();
          },
          title: "إلغاء",
          width: 100.w,
          height: 50.h,
          buttonColor: AppColors.greyIcon,
        ),
      ],
    );
  }
}
