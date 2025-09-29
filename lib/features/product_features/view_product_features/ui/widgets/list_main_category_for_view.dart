import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import 'custom_get_main_category_for_view_success_widget.dart';
import 'shimmer_for_main_category_for_view.dart';

class ListMainCategoryForView extends StatelessWidget {
  final int storeProductsFilter;
  const ListMainCategoryForView({super.key, required this.storeProductsFilter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoryNamesCubit,
        GetCategoryNamesState>(
      builder: (context, state) {
        if (state is GetCategoryNamesSuccess) {
          final mainCategoryForViewEntity = state.categoryAndSubCategoryNames;
          // Create "الكل" category as first chip
          final List<CategoryEntity> allCategory = [
            CategoryEntity(
              categoryParentId: 0,
              categoryType: 1,
                categoryId: 0000, categoryName: "الكل",categoryImage: '', categoryLevel: 1  )
          ];
          allCategory.addAll(mainCategoryForViewEntity);

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                context
                    .read<GetMainCategoryForViewCubit>()
                    .getMainCategoryForView(
                        pageNumber: (allCategory.length ~/ 10) + 1,
                        pageSize: 10);
              }
              return false;
            },
            child: CustomGetMainCategoryForViewSuccessWidget(
              allCategory: allCategory,
              storeProductsFilter: storeProductsFilter,
              isLoadingMore: state is GetCategoryNamesPaganiationLoading,
            ),
          );
        } else if (state is GetCategoryNamesFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is GetCategoryNamesLoading) {
          return ShimmerForMainCategoryForView();
        } else {
          return Center(
            child: Container(
              color: Colors.red.shade400,
              height: 50,
              width: 300,
              child: const Text('لم يتم الوصول الى المعلومات'),
            ),
          );
        }
      },
    );
  }
}
