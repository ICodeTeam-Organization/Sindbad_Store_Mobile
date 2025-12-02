import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/swidgets/no_data_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/general_filter_bar.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/product_card_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/shimmer_for_products_with_filter.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../manager/get_category_cubit/get_category_cubit.dart';
import '../manager/products_cubit/products_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import '../../../../../config/styles/Colors.dart';

class AllProductsTap extends StatefulWidget {
  const AllProductsTap({
    super.key,
  });

  @override
  State<AllProductsTap> createState() => _AllProductsTapState();
}

class _AllProductsTapState extends State<AllProductsTap> {
  final ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsCubit>().getProducts(_pageNumber, 10, null);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Debug print to check scroll values
    // print('Pixels: ${_scrollController.position.pixels}, Max: ${_scrollController.position.maxScrollExtent}');

    // Check if we are near the bottom (within 50 pixels)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<ProductsCubit>().state;
      if (state is ProductsLoadSuccess) {
        _pageNumber++;
        print('Fetching page $_pageNumber');
        context.read<ProductsCubit>().getProducts(_pageNumber, 10, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenericFilterBar<StoreCategoryModel>(
          onChanged: (int? categoryId) {
            // context.read<ProductsCubit>().getStoreProductsWitheFilter(
            //     storeProductsFilter: 0,
            //     categoryId: categoryId,
            //     pageNumber: 1,
            //     pageSize: 10);
          },
          dataFetcher: (int page, int size) =>
              context.read<GetCategory>().getMainCategory(1, 10),
          getName: (item) => item.categoryName,
          getId: (item) => item.id,
          selectedId: 0,
        ),
        // CategoryFilterBarTemp(
        //   storeProductsFilter: 2,
        // ),
        Padding(
          padding:
              EdgeInsets.only(top: 10.h, left: 15.w, right: 15.w, bottom: 5.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StorePrimaryButton(
                // disabled: !anyProductsSelected,
                title: "أضافة منتجات",
                svgIconPath: 'assets/svgs/add.svg',
                buttonColor: AppColors.primary,
                height: 32.h,
                width: 126.w,
                onTap: () {
                  context.push(
                    AppRoutes.addProduct,
                  );
                },
              ),
              StorePrimaryButton(
                // disabled: anyProductsSelected,
                title: "ايقاف منتجات",
                icon: Icons.refresh,
                buttonColor: Color(0xFFD9D9D9),
                height: 32.h,
                width: 126.w,
                onTap: () {},
              )
            ],
          ),
        ),

        SizedBox(height: 15.h),
        Expanded(
          child: BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
            final allProducts = context.read<ProductsCubit>().allProducts;

            if (state is ProductsInitial ||
                (state is ProductsLoadInProgress && allProducts.isEmpty)) {
              return ShimmerForProductsWithFilter();
            } else if (state is ProductsLoadSuccess ||
                (state is ProductsLoadInProgress && allProducts.isNotEmpty)) {
              return allProducts.isEmpty
                  ? NoDataWidget()
                  : AnimationLimiter(
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: allProducts.length +
                            (state is ProductsLoadInProgress ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == allProducts.length) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          ProductEntity product = allProducts[index];
                          bool isEven = index % 2 == 0;

                          return ProductCardWidget(
                              products: allProducts,
                              isEven: isEven,
                              product: product);
                        },
                      ),
                    );
            } else if (state is ProductsLoadFailure) {
              return ErrorWidget(state.errMessage);
            } else {
              return ErrorWidget("هناك خطأ ما...");
            }
          }),
        ),
      ],
    );
  }
}
