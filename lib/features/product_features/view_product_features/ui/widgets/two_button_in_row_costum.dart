import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';

class TwoButtonInRow extends StatelessWidget {
  const TwoButtonInRow({
    super.key,
    this.titleRight = "إضافة منتج",
    this.titleLeft = "إيقاف منتج",
    required this.onTapLeft,
    required this.anyProductsSelected,
  });

  final String titleRight;
  final String titleLeft;
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
              // for refresh the store products after add new product
              context
                  .read<GetStoreProductsWithFilterCubit>()
                  .getStoreProductsWitheFilter(
                    storeProductsFilter: context
                            .read<GetStoreProductsWithFilterCubit>()
                            .currentStoreProductsFilter ??
                        0,
                    categoryId: context
                        .read<GetStoreProductsWithFilterCubit>()
                        .currentMainCategoryId,
                    pageNumber: 1,
                    pageSize: 100,
                  );
              context.push(
                AppRouter.storeRouters.kStoreAddProduct,
              );
            },
          ),
          StorePrimaryButton(
            disabled: anyProductsSelected,
            title: titleLeft,
            icon: Icons.refresh,
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
