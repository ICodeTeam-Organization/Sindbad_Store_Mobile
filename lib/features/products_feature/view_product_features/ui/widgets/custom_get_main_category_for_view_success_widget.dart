import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/main_category_for_view_entity.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'sub_category_card_custom.dart';

class CustomGetMainCategoryForViewSuccessWidget extends StatefulWidget {
  const CustomGetMainCategoryForViewSuccessWidget({
    super.key,
    required this.allCategory,
    required this.storeProductsFilter,
    required this.isLoadingMore,
  });

  final List<MainCategoryForViewEntity> allCategory;
  final int storeProductsFilter;
  final bool isLoadingMore;

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
      height: 50.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.allCategory.length +
              (widget.isLoadingMore
                  ? 1
                  : 0), // Add one for the loading indicator if loading more
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, i) {
            if (i == widget.allCategory.length) {
              return Center(child: CircularProgressIndicator());
            }
            final category = widget.allCategory[i];
            return ChipCustom(
              title: category.mainCategoryName,
              isSelected: i == _selectedSubIndex,
              onTap: () {
                cubitGetStoreProducts.getStoreProductsWitheFilter(
                    storeProductsFilter: widget.storeProductsFilter,
                    categoryId: i == 0 ? null : category.mainCategoryId,
                    pageNumber: 1,
                    pageSize: 100);
                debugPrint("Selected Category: ${category.mainCategoryName}");
                setState(() {
                  _selectedSubIndex = i;
                });
              },
            );
          }),
    );
  }
}
