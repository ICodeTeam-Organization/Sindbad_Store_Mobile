import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/swidgets/no_data_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/screens/view_product_screen.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/general_filter_bar.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/product_card_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/shimmer_for_products_with_filter.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/two_button_in_row_costum.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../manager/disable_products/disable_products_by_ids_cubit.dart';
import '../manager/get_category_cubit/get_category_cubit.dart';
import '../manager/products_cubit/products_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import '../../../../../core/swidgets/new_widgets/store_primary_button.dart';
import '../../../../../config/styles/Colors.dart';
import '../manager/products_cubit/products_cubit.dart';

class OfferedProdutsTap extends StatefulWidget {
  const OfferedProdutsTap({
    super.key,
  });

  @override
  State<OfferedProdutsTap> createState() => _OfferedProdutsTapState();
}

class _OfferedProdutsTapState extends State<OfferedProdutsTap> {
  @override
  void initState() {
    super.initState();
    // context
    //     .read<GetMainCategoryForViewCubit>()
    //     .getMainCategory(pageNumber: 1, pageSize: 10);
    context.read<ProductsCubit>().getProducts(1, 10, null);
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
            if (state is ProductsInitial || state is ProductsLoadInProgress) {
              return ShimmerForProductsWithFilter();
            } else if (state is ProductsLoadSuccess) {
              final List<ProductEntity> products = state.products;
              return products.isEmpty
                  ? NoDataWidget()
                  : AnimationLimiter(
                      child: ListView.builder(
                        //controller: _scrollController,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          if (index == products.length) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          ProductEntity product = products[index];
                          bool isEven = index % 2 == 0;

                          return ProductCardWidget(
                              products: products,
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
