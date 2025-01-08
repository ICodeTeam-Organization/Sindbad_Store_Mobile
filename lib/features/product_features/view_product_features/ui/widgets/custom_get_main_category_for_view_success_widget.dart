import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/main_category_for_view_entity.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'sub_category_card_custom.dart';

class CustomGetMainCategoryForViewSuccessWidget extends StatefulWidget {
  const CustomGetMainCategoryForViewSuccessWidget({
    super.key,
    required this.allCategory,
    required this.storeProductsFilter,
  });

  final List<MainCategoryForViewEntity> allCategory;
  final int storeProductsFilter;

  @override
  State<CustomGetMainCategoryForViewSuccessWidget> createState() =>
      _CustomGetMainCategoryForViewSuccessWidgetState();
}

class _CustomGetMainCategoryForViewSuccessWidgetState
    extends State<CustomGetMainCategoryForViewSuccessWidget> {
  int _selectedSubIndex = 0;
  late GetStoreProductsWithFilterCubit cubitGetStoreProducts;
  @override
  void initState() {
    super.initState();
    cubitGetStoreProducts = context.read<GetStoreProductsWithFilterCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:  53.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.allCategory.length, // Use the length of the list
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final category = widget.allCategory[i];
            return ChipCustom(
              title: category.mainCategoryName,
              isSelected: i == _selectedSubIndex,
              onTap: () {
                //
                cubitGetStoreProducts.getStoreProductsWitheFilter(
                    storeProductsFilter: widget.storeProductsFilter,
                    categoryId: i == 0 ? null : category.mainCategoryId,
                    pageNumper: 1,
                    pageSize: 100);
                //
                debugPrint("Selected Category: ${category.mainCategoryName}");
                _selectedSubIndex = i;
                setState(() {});
              },
            );
          }),
    );
  }
}
