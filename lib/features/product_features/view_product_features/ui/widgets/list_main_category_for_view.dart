import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import 'custom_get_main_category_for_view_success_widget.dart';
import 'shimmer_for_main_category_for_view.dart';

class ListMainCategoryForView extends StatelessWidget {
  final int storeProductsFilter;
  const ListMainCategoryForView({super.key, required this.storeProductsFilter});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMainCategoryForViewCubit,
        GetMainCategoryForViewState>(
      builder: (context, state) {
        if (state is GetMainCategoryForViewSuccess) {
          final mainCategoryForViewEntity = state.mainCategoryForViewEntity;
          // Create "الكل" category as first chip
          final List<MainCategoryForViewEntity> allCategory = [
            MainCategoryForViewEntity(
                mainCategoryId: 0000, mainCategoryName: "الكل")
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
              isLoadingMore: state.isLoadingMore,
            ),
          );
        } else if (state is GetMainCategoryForViewFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is GetMainCategoryForViewLoading) {
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
