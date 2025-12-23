import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/core/dialogs/ErrorDialog.dart';
import 'package:sindbad_management_app/core/dialogs/stopped_dialog.dart';
import 'package:sindbad_management_app/core/widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/widgets/no_data_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/general_filter_bar.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/product_card_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/shimmer_for_products_with_filter.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/shimmer_product_item.dart';
import 'package:sindbad_management_app/features/profile_feature/data/model/store_category_model.dart';
import '../manager/get_category_cubit/get_category_cubit.dart';
import '../manager/products_cubit/products_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import '../../../../../config/styles/Colors.dart';

class StoppedProductsTap extends StatefulWidget {
  const StoppedProductsTap({
    super.key,
  });

  @override
  State<StoppedProductsTap> createState() => _StoppedProductsTapState();
}

class _StoppedProductsTapState extends State<StoppedProductsTap> {
  final ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ProductsCubit>().getStoppedProducts(_pageNumber, 10, null);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Check if we are near the bottom (within 50 pixels)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 50) {
      final state = context.read<ProductsCubit>().state;
      if (state is ProductsLoadSuccess) {
        _pageNumber++;
        print('Fetching stopped products page $_pageNumber');
        context.read<ProductsCubit>().getStoppedProducts(_pageNumber, 10, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(height: 10.h),
        _buildActionsButtons(context, l10n, theme),
        SizedBox(height: 15.h),
        _buildProductsList(l10n)
      ],
    );
  }

  Expanded _buildProductsList(AppLocalizations l10n) {
    return Expanded(
      child: BlocConsumer<ProductsCubit, ProductsState>(
        buildWhen: (previous, current) => current is! ProductsLoadFailure,
        builder: (context, state) {
          final cubit = context.read<ProductsCubit>();
          final allProducts = cubit.stoppedProducts;
          final selectedProducts = cubit.selectedStoppedProducts;

          // keep selected items first (preserve order from selectedProducts),
          // then append the unselected items
          final selectedList = selectedProducts.toList();
          final unselectedList = allProducts
              .where((p) => !selectedProducts.any((s) => s.id == p.id))
              .toList();

          final displayProducts = [...selectedList, ...unselectedList];

          if (state is ProductsInitial ||
              (state is ProductsLoadInProgress && allProducts.isEmpty)) {
            return ShimmerForProductsWithFilter();
          } else if (state is ProductsLoadSuccess ||
              (state is ProductsLoadInProgress && allProducts.isNotEmpty)) {
            return displayProducts.isEmpty
                ? NoDataWidget()
                : AnimationLimiter(
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: displayProducts.length +
                          (state is ProductsLoadInProgress ? 3 : 0),
                      itemBuilder: (context, index) {
                        // loading footer
                        if (index >= displayProducts.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ShimmerProductItem(),
                            ),
                          );
                        }

                        final product = displayProducts[index];
                        final isEven = index % 2 == 0;

                        // mark selected if product exists in selectedProducts
                        final isSelected =
                            selectedProducts.any((s) => s.id == product.id);

                        return ProductCardWidget(
                          products: displayProducts,
                          isEven: isEven,
                          product: product,
                          selected: isSelected,
                          onToggleSelection: (id) {
                            context
                                .read<ProductsCubit>()
                                .toggleStoppedProductSelection(id);
                          },
                        );
                      },
                    ),
                  );
          } else if (state is ProductsLoadFailure) {
            return ErrorWidget(state.errMessage);
          } else {
            return ErrorWidget(l10n.somethingWentWrong);
          }
        },
        listener: (BuildContext context, ProductsState state) {
          if (state is ProductsLoadFailure) {
            showErrorDialog(
                context: context,
                title: l10n.error,
                description: state.errMessage,
                buttonText: l10n.ok);
          }
        },
      ),
    );
  }

  Padding _buildActionsButtons(
      BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StorePrimaryButton(
            title: l10n.addProducts,
            svgIconPath: 'assets/svgs/add.svg',
            buttonColor: theme.colorScheme.primary,
            height: 32.h,
            width: 126.w,
            onTap: () {
              context.push(
                AppRoutes.addProduct,
              );
            },
          ),
          StorePrimaryButton(
            disabled: context.select(
                (ProductsCubit cubit) => cubit.selectedStoppedProducts.isEmpty),
            title: l10n.reactivate,
            icon: Icons.refresh,
            buttonColor: Colors.green,
            height: 32.h,
            width: 126.w,
            onTap: () {
              showProductSelectionDialog(
                  title: l10n.reactivateProducts,
                  context: context,
                  products:
                      context.read<ProductsCubit>().selectedStoppedProducts,
                  onConfirm: () {
                    // TODO: Add activateSelectedProducts method
                    context.read<ProductsCubit>().activateSelectedProducts();
                  });
            },
          )
        ],
      ),
    );
  }

  BlocBuilder<GetCategory, GetCategoryState> buildCategoryFilterBar() {
    return BlocBuilder<GetCategory, GetCategoryState>(
      builder: (context, state) {
        if (state is GetCategoryLoadInProgress) {
          return GenericFilterBar<StoreCategoryModel>(
            items: const [],
            isLoading: true,
            getName: (item) => item.categoryName,
            getId: (item) => item.id,
            selectedId: 0,
          );
        }

        if (state is GetCategoryLoadSuccess) {
          return GenericFilterBar<StoreCategoryModel>(
            items: state.categoryies,
            isLoading: false,
            onChanged: (int? categoryId) {
              // TODO: Filter stopped products by category
            },
            onLoadMore: () {
              final cubit = context.read<GetCategory>();
              int nextPage = (state.categoryies.length ~/ 10) + 1;
              cubit.getMainCategory(nextPage, 10);
            },
            getName: (item) => item.categoryName,
            getId: (item) => item.id,
            selectedId: 0,
          );
        }

        // Default/initial state
        return GenericFilterBar<StoreCategoryModel>(
          items: const [],
          isLoading: false,
          getName: (item) => item.categoryName,
          getId: (item) => item.id,
          selectedId: 0,
        );
      },
    );
  }
}
