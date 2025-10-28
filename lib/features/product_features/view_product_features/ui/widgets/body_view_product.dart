import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/use_cases/get_main_and_sub_category_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/widgets/list_main_category_for_view.dart';
import '../../../../../core/swidgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/swidgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../config/styles/Colors.dart';
import '../manager/activate_products/activate_products_by_ids_cubit.dart';
import '../manager/disable_products/disable_products_by_ids_cubit.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'custom_show_dialog_for_view_widget.dart';
import 'products_list_view_widget.dart';
import 'two_button_in_row_costum.dart';

class BodyViewProductScreen extends StatefulWidget {
  const BodyViewProductScreen({super.key});

  @override
  BodyViewProductScreenState createState() => BodyViewProductScreenState();
}

class BodyViewProductScreenState extends State<BodyViewProductScreen> {
  late GetStoreProductsWithFilterCubit cubitGetStoreProducts;
  late DisableProductsByIdsCubit cubitDisableProducts;
  initCubitGetStoreProducts() {
    cubitGetStoreProducts = context.read<GetStoreProductsWithFilterCubit>();
  }

  initCubitDisableProducts() {
    cubitDisableProducts = context.read<DisableProductsByIdsCubit>();
  }

  @override
  void initState() {
    super.initState();
    initCubitGetStoreProducts();
    initCubitDisableProducts();
    // context.read<GetCategoryNamesCubit>().fetchDataFromHive();
    context.read<GetMainCategoryForViewCubit>().getMainCategoryForView(
        pageNumber: 1, pageSize: 10); // for get Main category
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              tital: "المنتجات",
              isBack: false,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: CustomTabBarWidget(
                tabs: [
                  Tab(text: "جميع المنتجات"),
                  Tab(text: "منتجات عليها عروض"),
                  Tab(text: "منتجات موقوفة"),
                ],
                tabViews: [
                  _buildTabView(0, context),
                  _buildTabView(1, context),
                  _buildTabView(2, context),
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
      ),
    );
  }

  Widget _buildTabView(int tabIndex, BuildContext context) {
    switch (tabIndex) {
      case 0: // all products
        return Column(
          children: [
            ListMainCategoryForView(
              storeProductsFilter: tabIndex,
            ),
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return TwoButtonInRow(
                  anyProductsSelected:
                      cubitGetStoreProducts.updatedProductsSelected.isEmpty,
                  onTapLeft: () {
                    showDisableOneOrMoreProductsDialog(
                      parentContext: context,
                      storeProductsFilter: tabIndex,
                      ids: cubitGetStoreProducts.updatedProductsSelected,
                      cubitDisableProducts: cubitDisableProducts,
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
      case 1: // products offers on it
        return Column(
          children: [
            ListMainCategoryForView(
              storeProductsFilter: tabIndex,
            ),
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return TwoButtonInRow(
                  anyProductsSelected:
                      cubitGetStoreProducts.updatedProductsSelected.isEmpty,
                  onTapLeft: () {
                    showDisableOneOrMoreProductsDialog(
                      parentContext: context,
                      storeProductsFilter: tabIndex,
                      ids: cubitGetStoreProducts.updatedProductsSelected,
                      cubitDisableProducts: cubitDisableProducts,
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
      case 2: // "منتجات موقوفة"
        return Column(
          children: [
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return TwoButtonInRow(
                  titleLeft: "إعادة تنشيط",
                  anyProductsSelected:
                      cubitGetStoreProducts.updatedProductsSelected.isEmpty,
                  onTapLeft: () {
                    showActivateOneOrMoreProductsDialog(
                      contextParent: context,
                      ids: cubitGetStoreProducts.updatedProductsSelected,
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
      default:
        return Container();
    }
  }
}

void showDisableOneOrMoreProductsDialog({
  required BuildContext parentContext,
  required int storeProductsFilter,
  required List<int> ids,
  required DisableProductsByIdsCubit cubitDisableProducts, // Add this parameter
}) {
  showDialog(
    context: parentContext,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: cubitDisableProducts, // Provide the cubit explicitly
        child:
            BlocConsumer<DisableProductsByIdsCubit, DisableProductsByIdsState>(
          listener: (dialogContext, state) {
            if (state is DisableProductsByIdsSuccess) {
              ScaffoldMessenger.of(parentContext).showSnackBar(
                SnackBar(content: Text('تم إيقاف المنتجات بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true)
                  .pop(); // Close dialog
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
