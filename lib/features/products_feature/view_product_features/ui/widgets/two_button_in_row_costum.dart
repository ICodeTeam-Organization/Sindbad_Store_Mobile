import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import '../../../../../core/swidgets/new_widgets/store_primary_button.dart';
import '../../../../../config/styles/Colors.dart';
import '../manager/products_cubit/products_cubit.dart';

class TwoButtonInRow extends StatelessWidget {
  const TwoButtonInRow({
    super.key,
    this.titleRight = "إضافة منتجات",
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
            svgIconPath: 'assets/svgs/add.svg',
            buttonColor: AppColors.primary,
            height: 32.h,
            width: 126.w,
            onTap: () {
              // for refresh the store products after add new product
              context.read<ProductsCubit>().getStoreProductsWitheFilter(
                    storeProductsFilter: context
                            .read<ProductsCubit>()
                            .currentStoreProductsFilter ??
                        0,
                    categoryId:
                        context.read<ProductsCubit>().currentMainCategoryId,
                    pageNumber: 1,
                    pageSize: 100,
                  );
              context.push(
                AppRoutes.addProduct,
              );
            },
          ),
          StorePrimaryButton(
            disabled: anyProductsSelected,
            title: titleLeft,
            icon: Icons.refresh,
            buttonColor: AppColors.primary,
            height: 32.h,
            width: 126.w,
            onTap: onTapLeft,
          )
        ],
      ),
    );
  }
}
