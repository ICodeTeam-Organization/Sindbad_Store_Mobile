import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/activate_products_by_ids_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';
import '../../../../../injection_container.dart';
import '../../../../../core/swidgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/swidgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../config/styles/Colors.dart';
import '../../../add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import '../../../add_and_edit_product_feature/domain/use_cases/get_product_details_to_store_use_case.dart';
import '../../../add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/use_cases/delete_product_by_id_use_case.dart';
import '../../domain/use_cases/get_main_category_for_view_use_case.dart';
import '../../domain/use_cases/get_products_by_filter_use_case.dart';
import '../manager/activate_products/activate_products_by_ids_cubit.dart';
import '../manager/delete_product_by_id_from_store/delete_product_by_id_from_store_cubit.dart';
import '../manager/disable_products/disable_products_by_ids_cubit.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/custom_show_dialog_for_view_widget.dart';
import '../widgets/products_list_view_widget.dart';
import '../widgets/two_button_in_row_costum.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetStoreProductsWithFilterCubit(
            GetProductsByFilterUseCase(
              getit.get<ViewProductRepoImpl>(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) =>
              GetMainCategoryForViewCubit(GetMainCategoryForViewUseCase(
            getit.get<ViewProductRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) =>
              DisableProductsByIdsCubit(DisableProductsByIdsUseCase(
            getit.get<ViewProductRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => DeleteProductByIdFromStoreCubit(
            DeleteProductByIdUseCase(
              getit.get<ViewProductRepoImpl>(),
            ),
          ),
        ),
        BlocProvider(
            create: (context) =>
                ActivateProductsByIdsCubit(ActivateProductsByIdsUseCase(
                  getit.get<ViewProductRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) =>
                ProductDetailsCubit(GetProductDetailsToStoreUseCase(
                  getit.get<AddAndEditProductStoreRepoImpl>(),
                ))),
      ],
      child: _ViewProductBody(),
    );
  }
}

class _ViewProductBody extends StatefulWidget {
  const _ViewProductBody();

  @override
  State<_ViewProductBody> createState() => _ViewProductBodyState();
}

class _ViewProductBodyState extends State<_ViewProductBody> {
  @override
  void initState() {
    super.initState();
    // Initialize the main category cubit - now the BLoCs are available
    context
        .read<GetMainCategoryForViewCubit>()
        .getMainCategoryForView(pageNumber: 1, pageSize: 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            tital: "المنتجات",
            isBack: false,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: CustomTabBarWidget(
              tabs: [
                Tab(
                  child: Text('جميع المنتجات',
                      textAlign: TextAlign.center,
                      style: TextTheme.of(context).titleMedium),
                ),
                Tab(
                    child: Text("منتجات عليها عروض",
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).titleMedium)),
                Tab(
                    child: Text("منتجات موقوفة",
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).titleMedium)),
              ],
              tabViews: [
                buildAllProductsTap(context, 0),
                buildOfferProductsTap(context, 1),
                buildStoppedProductsTap(context, 2),
              ],
              length: 3,
              indicatorColor: AppColors.primary,
              indicatorWeight: 0.0.w,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the view for all products tab
  Widget buildAllProductsTap(BuildContext context, int tabIndex) {
    return Column(
      children: [
        CategoryFilterBar(
          storeProductsFilter: tabIndex,
        ),
        BlocBuilder<GetStoreProductsWithFilterCubit,
            GetStoreProductsWithFilterState>(
          builder: (context, state) {
            return TwoButtonInRow(
              anyProductsSelected: context
                  .read<GetStoreProductsWithFilterCubit>()
                  .updatedProductsSelected
                  .isEmpty,
              onTapLeft: () {
                showDisableOneOrMoreProductsDialog(
                  parentContext: context,
                  storeProductsFilter: tabIndex,
                  ids: context
                      .read<GetStoreProductsWithFilterCubit>()
                      .updatedProductsSelected,
                  cubitDisableProducts:
                      context.read<DisableProductsByIdsCubit>(),
                );
              },
            );
          },
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: ProductsListView(
            storeProductsFilter: tabIndex,
          ),
        ),
      ],
    );
  }

  /// Builds the view for products with offers tab
  Widget buildOfferProductsTap(BuildContext context, int tabIndex) {
    return Column(
      children: [
        CategoryFilterBar(
          storeProductsFilter: tabIndex,
        ),
        BlocBuilder<GetStoreProductsWithFilterCubit,
            GetStoreProductsWithFilterState>(
          builder: (context, state) {
            return TwoButtonInRow(
              anyProductsSelected: context
                  .read<GetStoreProductsWithFilterCubit>()
                  .updatedProductsSelected
                  .isEmpty,
              onTapLeft: () {
                showDisableOneOrMoreProductsDialog(
                  parentContext: context,
                  storeProductsFilter: tabIndex,
                  ids: context
                      .read<GetStoreProductsWithFilterCubit>()
                      .updatedProductsSelected,
                  cubitDisableProducts:
                      context.read<DisableProductsByIdsCubit>(),
                );
              },
            );
          },
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: ProductsListView(
            storeProductsFilter: tabIndex,
          ),
        ),
      ],
    );
  }

  /// Builds the view for stopped/disabled products tab
  Widget buildStoppedProductsTap(BuildContext context, int tabIndex) {
    return Column(
      children: [
        BlocBuilder<GetStoreProductsWithFilterCubit,
            GetStoreProductsWithFilterState>(
          builder: (context, state) {
            return TwoButtonInRow(
              titleLeft: "إعادة تنشيط",
              anyProductsSelected: context
                  .read<GetStoreProductsWithFilterCubit>()
                  .updatedProductsSelected
                  .isEmpty,
              onTapLeft: () {
                showActivateOneOrMoreProductsDialog(
                  contextParent: context,
                  ids: context
                      .read<GetStoreProductsWithFilterCubit>()
                      .updatedProductsSelected,
                  storeProductsFilter: tabIndex,
                  activateProductsCubit:
                      context.read<ActivateProductsByIdsCubit>(),
                );
              },
            );
          },
        ),
        SizedBox(height: 15.h),
        Expanded(
          child: ProductsListView(
            storeProductsFilter: tabIndex,
          ),
        ),
      ],
    );
  }
}

void showDisableOneOrMoreProductsDialog({
  required BuildContext parentContext,
  required int storeProductsFilter,
  required List<int> ids,
  required DisableProductsByIdsCubit cubitDisableProducts,
}) {
  showDialog(
    context: parentContext,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: cubitDisableProducts,
        child:
            BlocConsumer<DisableProductsByIdsCubit, DisableProductsByIdsState>(
          listener: (dialogContext, state) {
            if (state is DisableProductsByIdsSuccess) {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text('تم إيقاف المنتجات بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true).pop();
              parentContext
                  .read<GetStoreProductsWithFilterCubit>()
                  .getStoreProductsWitheFilter(
                    storeProductsFilter: storeProductsFilter,
                    categoryId: parentContext
                        .read<GetStoreProductsWithFilterCubit>()
                        .currentMainCategoryId,
                    pageNumber: 1,
                    pageSize: 100,
                  );
            } else if (state is DisableProductsByIdsFailure) {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
          builder: (dialogContext, state) {
            return CustomShowDialogForViewWidget(
              title: 'هل انت متأكد من إيقاف المنتجات؟',
              subtitle: 'عدد المنتجات التي تريد إيقافها : ${ids.length}',
              isLoading: state is DisableProductsByIdsLoading,
              onConfirm: () =>
                  cubitDisableProducts.disableProductsByIds(ids: ids),
              confirmText: "إيقاف",
              cancelText: 'إلغاء',
            );
          },
        ),
      );
    },
  );
}

void showActivateOneOrMoreProductsDialog({
  required BuildContext contextParent,
  required List<int> ids,
  required int storeProductsFilter,
  required ActivateProductsByIdsCubit activateProductsCubit,
}) {
  showDialog(
    context: contextParent,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: activateProductsCubit,
        child: BlocConsumer<ActivateProductsByIdsCubit,
            ActivateProductsByIdsState>(
          listener: (dialogContext, state) {
            if (state is ActivateProductsByIdsSuccess) {
              ScaffoldMessenger.of(contextParent).showSnackBar(
                SnackBar(content: Text('تم إعادة تنشيط المنتج بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true).pop();
              contextParent
                  .read<GetStoreProductsWithFilterCubit>()
                  .getStoreProductsWitheFilter(
                    storeProductsFilter: storeProductsFilter,
                    categoryId: contextParent
                        .read<GetStoreProductsWithFilterCubit>()
                        .currentMainCategoryId,
                    pageNumber: 1,
                    pageSize: 100,
                  );
            } else if (state is ActivateProductsByIdsFailure) {
              ScaffoldMessenger.of(contextParent).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
          builder: (dialogContext, state) {
            return CustomShowDialogForViewWidget(
              title: ids.length > 1
                  ? 'هل انت متأكد من إعادة تنشيط المنتجات؟'
                  : 'إعادة تنشيط المنتج',
              subtitle: ids.length > 1
                  ? 'عدد المنتجات التي تريد تنشطيها : ${ids.length}'
                  : 'هل تريد بالتأكيد إعادة تنشيط هذا المنتج؟',
              isLoading: state is ActivateProductsByIdsLoading,
              onConfirm: () =>
                  activateProductsCubit.activateProductsByIds(ids: ids),
              confirmText: 'إعادة تنشيط',
              cancelText: 'إلغاء',
            );
          },
        ),
      );
    },
  );
}
