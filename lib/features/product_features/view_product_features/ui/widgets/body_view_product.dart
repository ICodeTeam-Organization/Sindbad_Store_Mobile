import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/widgets/list_main_category_for_view.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../core/styles/Colors.dart';
import '../manager/activate_products/activate_products_by_ids_cubit.dart';
import '../manager/disable_products/disable_products_by_ids_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'custom_show_dialog_for_view_widget.dart';
import 'products_listview_widget.dart';
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

  // بناء محتوى التبويب بناءً على التحديد
  Widget _buildTabView(int tabIndex, BuildContext context) {
    switch (tabIndex) {
      case 0: // "جميع المنتجات"

        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
            ListMainCategoryForView(
              storeProductsFilter: tabIndex,
            ),
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return BlocListener<DisableProductsByIdsCubit,
                    DisableProductsByIdsState>(
                  listener: (context, state) {
                    if (state is DisableProductsByIdsSuccess) {
                      cubitGetStoreProducts.getStoreProductsWitheFilter(
                        storeProductsFilter: tabIndex,
                        pageNumper: 1,
                        pageSize: 100,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message.message)));
                      // إغلاق مربع الحوار
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // استخدم rootNavigator
                    }
                    if (state is DisableProductsByIdsFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errMessage)),
                      );
                    }
                    // يمكنك أيضًا التعامل مع حالة التحميل هنا إذا لزم الأمر
                  },
                  child: TwoButtonInRow(
                    anyProductsSelected:
                        cubitGetStoreProducts.updatedProductsSelected.isEmpty,
                    onTapLeft: () {
                      showDialog(
                        context: context, // تمرير السياق الصحيح
                        builder: (BuildContext context) {
                          final List<int> selectedProducts =
                              cubitGetStoreProducts.updatedProductsSelected;
                          return CustomShowDialogForViewWidget(
                            isLoading: false,
                            title: 'هل انت متأكد من إيقاف المنتجات؟',
                            subtitle:
                                'عدد المنتجات التي تريد إيقافها : ${selectedProducts.length}',
                            confirmText: "إيقاف",
                            cancelText: "إلغاء",
                            onConfirm: () {
                              cubitDisableProducts.disableProductsByIds(
                                  ids: selectedProducts);
                            },
                          );
                        },
                      );
                    },
                  ),
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
      case 1: // "منتجات عليها عروض"
        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
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
                    showDialog(
                      context: context, // تمرير السياق الصحيح
                      builder: (BuildContext context) {
                        final List<int> selectedProducts =
                            cubitGetStoreProducts.updatedProductsSelected;
                        return CustomShowDialogForViewWidget(
                          isLoading: false,
                          title: 'هل انت متأكد من إيقاف المنتجات؟',
                          subtitle:
                              'عدد المنتجات التي تريد إيقافها : ${selectedProducts.length}',
                          confirmText: "إيقاف",
                          cancelText: "إلغاء",
                          onConfirm: () {
                            cubitDisableProducts.disableProductsByIds(
                                ids: selectedProducts);
                          },
                        );
                      },
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
                    showActivateMoreProductDialog(
                      contextParent: context,
                      productsIds:
                          cubitGetStoreProducts.updatedProductsSelected,
                      storeProductsFilter: tabIndex,
                      activateProductsCubit:
                          context.read<ActivateProductsByIdsCubit>(),
                    );
                  },
                );
              },
            ),
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

void showActivateMoreProductDialog({
  required BuildContext contextParent,
  required List<int> productsIds,
  required int storeProductsFilter,
  required ActivateProductsByIdsCubit
      activateProductsCubit, // Add this parameter
}) {
  showDialog(
    context: contextParent,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: activateProductsCubit, // Provide the cubit explicitly
        child: BlocConsumer<ActivateProductsByIdsCubit,
            ActivateProductsByIdsState>(
          listener: (dialogContext, state) {
            if (state is ActivateProductsByIdsSuccess) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(content: Text('تم إعادة تنشيط المنتجات بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true)
                  .pop(); // Close dialog
              contextParent
                  .read<GetStoreProductsWithFilterCubit>()
                  .getStoreProductsWitheFilter(
                    storeProductsFilter: storeProductsFilter,
                    pageNumper: 1,
                    pageSize: 100,
                  );
            } else if (state is ActivateProductsByIdsFailure) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
          builder: (dialogContext, state) {
            return CustomShowDialogForViewWidget(
              isLoading: state is ActivateProductsByIdsLoading,
              title: 'هل انت متأكد من إعادة تنشيط المنتجات؟',
              subtitle:
                  'عدد المنتجات التي تريد إعادة تنشيطها : ${productsIds.length}',
              confirmText: "إعادة تنشيط",
              cancelText: "إلغاء",
              onConfirm: () => dialogContext
                  .read<ActivateProductsByIdsCubit>()
                  .activateProductsByIds(ids: productsIds),
            );
          },
        ),
      );
    },
  );
}
