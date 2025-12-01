import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/products_cubit/products_cubit.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/products_list_view_widget.dart';
import '../widgets/two_button_in_row_costum.dart';

class ProductsTabContent extends StatelessWidget {
  final int storeProductsFilter;
  final bool showCategoryFilter;
  final Function() onTapLeft;
  final String leftButtonTitle;

  const ProductsTabContent({
    super.key,
    required this.storeProductsFilter,
    this.showCategoryFilter = true,
    required this.onTapLeft,
    this.leftButtonTitle = "إيقاف منتج",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showCategoryFilter)
          // CategoryFilterBarTemp(
          //   storeProductsFilter: storeProductsFilter,
          // ),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return TwoButtonInRow(
                titleLeft: leftButtonTitle,
                anyProductsSelected: context
                    .read<ProductsCubit>()
                    .updatedProductsSelected
                    .isEmpty,
                onTapLeft: onTapLeft,
              );
            },
          ),
        SizedBox(height: 15.h),
        Expanded(
          child: ProductsListView(
            storeProductsFilter: storeProductsFilter,
          ),
        ),
      ],
    );
  }
}
