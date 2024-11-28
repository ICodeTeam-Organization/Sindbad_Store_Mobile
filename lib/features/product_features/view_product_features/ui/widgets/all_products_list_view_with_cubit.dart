import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/route.dart';
import '../manager/cubit/cubit/get_store_products_with_filter_cubit.dart';
import '../screens/fake_data _for_test.dart/test_data_cat.dart';
import 'products_listview_widget.dart';

class AllProductsListViewwithCubit extends StatelessWidget {
  final List<bool> disableProductCheckedStates;
  final List<Map<String, dynamic>> data;
  final void onChangeCheckBox;
  const AllProductsListViewwithCubit(
      {super.key,
      required this.disableProductCheckedStates,
      this.onChangeCheckBox,
      required this.data});

  @override
  Widget build(BuildContext context) {
    context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(1, 1, 1);
    return BlocBuilder<GetStoreProductsWithFilterCubit,
        GetStoreProductsWithFilterState>(
      builder: (context, state) {
        if (state is GetStoreProductsWithFilterLoading) {
          return CircularProgressIndicator();
        } else if (state is GetStoreProductsWithFilterSuccess) {
          return ProductsListView(
            products: state.products,
            checkedStates: disableProductCheckedStates, // تمرير الحالات
            onChanged: (val, index) => onChangeCheckBox, // تمرير index
            onTapDelete: () {
              // تنفيذ الحذف
            },
            onTapEdit: () {
              // تنفيذ التعديل
              context.push(AppRouter.storeRouters.kStoreEditProduct,
                  extra: 1 // here pass the product id
                  );
            },
          );
        } else if (state is GetStoreProductsWithFilterFailure) {
          return Text(state.errMessage);
        } else {
          return SizedBox();
        }
      },
    );
  }
}
