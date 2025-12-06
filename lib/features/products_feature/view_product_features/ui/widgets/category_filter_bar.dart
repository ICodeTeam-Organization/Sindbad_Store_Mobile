import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../manager/get_category_cubit/get_category_cubit.dart';
import 'custom_get_main_category_for_view_success_widget.dart';
import 'shimmer_for_main_category_for_view.dart';

// class CategoryFilterBarTemp extends StatefulWidget {
//   final int storeProductsFilter;
//   const CategoryFilterBarTemp({super.key, required this.storeProductsFilter});

//   @override
//   State<CategoryFilterBarTemp> createState() => _CategoryFilterBarTempState();
// }

// class _CategoryFilterBarTempState extends State<CategoryFilterBarTemp> {
//   @override
//   void initState() {
//     super.initState();
//     // Initialize the main category cubit - now the BLoCs are available
//     context
//         .read<GetCategory>()
//         .getMainCategoryForView(pageNumber: 1, pageSize: 10);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetCategory, GetCategoryState>(
//       builder: (context, state) {
//         if (state is GetCategoryLoadSuccess) {
//           final mainCategoryForViewEntity = state.categoryies;
//           // Create "الكل" category as first chip
//           final List<StoreCategoryModel> allCategory = [
//             StoreCategoryModel(
//                 id: 0000, categoryName: "الكل", categoryImageUrl: '')
//           ];
//           allCategory.addAll(mainCategoryForViewEntity);

//           return NotificationListener<ScrollNotification>(
//             onNotification: (ScrollNotification scrollInfo) {
//               if (scrollInfo.metrics.pixels ==
//                   scrollInfo.metrics.maxScrollExtent) {
//                 context.read<GetCategory>().getMainCategoryForView(
//                     pageNumber: (allCategory.length ~/ 10) + 1, pageSize: 10);
//               }
//               return false;
//             },
//             child: CustomGetMainCategoryForViewSuccessWidget(
//               allCategory: allCategory,
//               storeProductsFilter: widget.storeProductsFilter,
//               isLoadingMore: state.isLoadingMore,
//             ),
//           );
//         } else if (state is GetCategoryLoadFailure) {
//           return Center(child: Text(state.errMessage));
//         } else if (state is GetCategoryLoadInProgress) {
//           return ShimmerForMainCategoryForView();
//         } else {
//           return Center(
//             child: Container(
//               color: Colors.red.shade400,
//               height: 50,
//               width: 300,
//               child: const Text('لم يتم الوصول الى المعلومات'),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

class CategoryFilterBar extends StatefulWidget {
  final int storeProductsFilter;
  final Function(int?)? onChanged;
  const CategoryFilterBar(
      {super.key, required this.storeProductsFilter, this.onChanged});

  @override
  State<CategoryFilterBar> createState() => _CategoryFilterBarState();
}

class _CategoryFilterBarState extends State<CategoryFilterBar> {
  @override
  void initState() {
    super.initState();
    // Initialize the main category cubit - now the BLoCs are available
    context.read<GetCategory>().getMainCategory(1, 10);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategory, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoadSuccess) {
          final mainCategoryForViewEntity = state.categoryies;
          // Create "الكل" category as first chip
          final List<StoreCategoryModel> allCategory = [
            StoreCategoryModel(
                id: 0000, categoryName: "الكل", categoryImageUrl: '')
          ];
          allCategory.addAll(mainCategoryForViewEntity);

          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                context
                    .read<GetCategory>()
                    .getMainCategory((allCategory.length ~/ 10) + 1, 10);
              }
              return false;
            },
            child: CustomGetMainCategoryForViewSuccessWidget(
              allCategory: allCategory,
              storeProductsFilter: widget.storeProductsFilter,
              isLoadingMore: false,
              onChanged: widget.onChanged,
            ),
          );
        } else if (state is GetCategoryLoadFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is GetCategoryLoadInProgress) {
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
