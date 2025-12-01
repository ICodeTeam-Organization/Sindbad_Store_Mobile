import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/general_filter_bar.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../manager/get_category_cubit/get_category_cubit.dart';

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
  Widget build(BuildContext context) {
    return BlocListener<GetCategory, GetCategoryState>(
      listener: (context, state) {
        if (state is GetCategoryLoadFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }
      },
      child: GenericFilterBar<StoreCategoryModel>(
        onChanged: widget.onChanged,
        dataFetcher: (int page, int size) async {
          var items =
              await context.read<GetCategory>().getMainCategory(page, size);
          if (page == 1) {
            return [
              StoreCategoryModel(
                  id: 0, categoryName: "الكل", categoryImageUrl: ''),
              ...items
            ];
          }
          return items;
        },
        getName: (item) => item.categoryName,
        getId: (item) => item.id,
        selectedId: widget.storeProductsFilter,
      ),
    );
  }
}
