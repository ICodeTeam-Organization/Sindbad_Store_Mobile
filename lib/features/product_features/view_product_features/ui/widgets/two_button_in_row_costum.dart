import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';

class TwoButtonInRow extends StatelessWidget {
  const TwoButtonInRow({
    super.key,
    // required this.productCheckedByNames,
    this.titleRight = "إضافة منتج",
    this.titleLeft = "إيقاف منتج",
    // required this.onTapRight,
    required this.onTapLeft,
    required this.anyProductsSelected,
  });

  // final List<String> productCheckedByNames;
  final String titleRight;
  final String titleLeft;
  // final void Function() onTapRight;
  final void Function() onTapLeft;
  final bool anyProductsSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 30.h, left: 15.w, right: 15.w, bottom: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StorePrimaryButton(
            disabled: !anyProductsSelected,
            title: titleRight,
            icon: Icons.add_circle_outline_rounded,
            buttonColor: AppColors.primary,
            height: 55.h,
            width: 150.w,
            onTap: () {
              // context.push(AppRouter.storeRouters.kStoreAddProduct); //////////
              context.push(
                AppRouter.storeRouters.kStoreAddProduct,
                extra: () {
                  context
                      .read<GetStoreProductsWithFilterCubit>()
                      .getStoreProductsWitheFilter(
                        storeProductsFilter: 0,
                        pageNumper: 1,
                        pageSize: 100,
                      );
                },
              );
            },
          ),
          StorePrimaryButton(
            disabled: anyProductsSelected,
            title: titleLeft,
            icon: Icons.delete_outline_rounded,
            buttonColor: AppColors.primary,
            height: 55.h,
            width: 150.w,
            onTap: onTapLeft,
          )
        ],
      ),
    );
  }
}
