import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../manager/products_cubit/products_cubit.dart';
import 'sub_category_card_custom.dart';

class CustomGetMainCategoryForViewSuccessWidget extends StatefulWidget {
  const CustomGetMainCategoryForViewSuccessWidget({
    super.key,
    required this.allCategory,
    required this.storeProductsFilter,
    required this.isLoadingMore,
    this.onChanged,
  });

  final List<StoreCategoryModel> allCategory;
  final int storeProductsFilter;
  final bool isLoadingMore;
  final Function(int?)? onChanged;

  @override
  State<CustomGetMainCategoryForViewSuccessWidget> createState() =>
      _CustomGetMainCategoryForViewSuccessWidgetState();
}

class _CustomGetMainCategoryForViewSuccessWidgetState
    extends State<CustomGetMainCategoryForViewSuccessWidget> {
  int _selectedSubIndex = 0;
  late ProductsCubit cubitGetStoreProducts;
  @override
  void initState() {
    super.initState();
    cubitGetStoreProducts = context.read<ProductsCubit>();
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
              title: category.categoryName,
              isSelected: i == _selectedSubIndex,
              onTap: () {
                cubitGetStoreProducts.getStoreProductsWitheFilter(
                    storeProductsFilter: widget.storeProductsFilter,
                    categoryId: i == 0 ? null : category.id,
                    pageNumber: 1,
                    pageSize: 100);
                debugPrint("Selected Category: ${category.categoryName}");
                widget.onChanged?.call(i == 0 ? null : category.id);
                setState(() {
                  _selectedSubIndex = i;
                });
              },
            );
          }),
    );
  }
}
