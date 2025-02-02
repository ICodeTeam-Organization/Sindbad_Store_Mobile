import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import '../../../../../core/utils/route.dart';
import '../../../add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import '../../../add_and_edit_product_feature/ui/screens/edit_product_screen.dart';
import '../../domain/entities/product_entity.dart';
import '../manager/activate_products/activate_products_by_ids_cubit.dart';
import '../manager/delete_product_by_id_from_store/delete_product_by_id_from_store_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'check_box_custom.dart';
import 'custom_show_dialog_for_view_widget.dart';
import 'image_card_custom.dart';
import 'shimmer_for_products_with_filter.dart';
import 'text_style_detials.dart';
import 'two_button_inside_list_view_products.dart';

class ProductsListView extends StatelessWidget {
  final int
      storeProductsFilter; // 1 => for all products, 2 => for deactivate products, 3 => for activate products
  const ProductsListView({
    super.key,
    required this.storeProductsFilter,
  });

  @override
  Widget build(BuildContext context) {
    final cubitGetStoreProducts =
        context.read<GetStoreProductsWithFilterCubit>();
    cubitGetStoreProducts.getStoreProductsWitheFilter(
        storeProductsFilter: storeProductsFilter, pageNumber: 1, pageSize: 100);

    return BlocBuilder<GetStoreProductsWithFilterCubit,
        GetStoreProductsWithFilterState>(
      builder: (context, state) {
        if (state is GetStoreProductsWithFilterLoading) {
          return ShimmerForProductsWithFilter();
        } else if (state is GetStoreProductsWithFilterSuccess) {
          final List<ProductEntity> products = state.products;

          return products.isEmpty
              ? Center(child: Text("لا يوجد منتجات"))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    ProductEntity product = products[index];
                    bool isEven = index % 2 == 0;
                    return Container(
                      margin: index + 1 == products.length
                          ? EdgeInsets.only(bottom: 100.h)
                          : null,
                      padding:
                          EdgeInsets.only(top: 26.h, bottom: 26.h, left: 10.w),
                      decoration: BoxDecoration(
                        color: isEven ? AppColors.background : Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        children: [
                          CheckBoxCustom(
                            val: state.checkedStates[index],
                            onChanged: (val) {
                              cubitGetStoreProducts.updateCheckboxState(
                                  index, val!, product.productId!);
                            },
                          ),
                          ImageCardCustom(
                            imageUrlNetwork: product.productImageUrl!,
                          ),
                          SizedBox(width: 10),
                          // Product Details
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextStyleTitleDataProductBold(
                                        title: 'اسم المنتج :  '),
                                    Expanded(
                                      child: TextStyleDataProductGreyDark(
                                          dataProduct: product.productName!),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextStyleTitleDataProductBold(
                                        title: 'رقم المنتج :  '),
                                    Expanded(
                                      child: TextStyleDataProductGreyDark(
                                          dataProduct:
                                              product.productNumber.toString()),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Text('السعر :  ',
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      '\$${product.productPrice.toString()}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.sp, color: Colors.red),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          // Action Buttons
                          TwoButtonInsideListViewProducts(
                            onTapEdit: () {
                              context
                                  .read<ProductDetailsCubit>()
                                  .getProductDetails(
                                    productId: product.productId!,
                                  );
                              showGetProductDetailsDialog(
                                contextParent: context,
                                productDetailsCubit:
                                    context.read<ProductDetailsCubit>(),
                              );
                            },
                            reactivate: storeProductsFilter ==
                                2, // if storeProductsFilter == 2 => for reactivate product
                            onTapDeleteOrReactivate: () {
                              storeProductsFilter ==
                                      2 // if storeProductsFilter == 2 => for reactivate product
                                  ? showActivateOneOrMoreProductsDialog(
                                      contextParent: context,
                                      ids: [product.productId!],
                                      storeProductsFilter: storeProductsFilter,
                                      activateProductsCubit: context
                                          .read<ActivateProductsByIdsCubit>(),
                                    )
                                  : showDeleteProductDialog(
                                      contextParent: context,
                                      productId: product.productId!,
                                      storeProductsFilter: storeProductsFilter,
                                      deleteProductCubit: context.read<
                                          DeleteProductByIdFromStoreCubit>(), // Pass the cubit
                                    );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
        } else if (state is GetStoreProductsWithFilterFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return Center(child: Text("هناك خطأ ما..."));
        }
      },
    );
  }
}

void showDeleteProductDialog({
  required BuildContext contextParent,
  required int productId,
  required int storeProductsFilter,
  required DeleteProductByIdFromStoreCubit
      deleteProductCubit, // Add this parameter
}) {
  showDialog(
    context: contextParent,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: deleteProductCubit, // Provide the cubit explicitly
        child: BlocConsumer<DeleteProductByIdFromStoreCubit,
            DeleteProductByIdFromStoreState>(
          listener: (dialogContext, state) {
            if (state is DeleteProductByIdFromStoreSuccess) {
              ScaffoldMessenger.of(contextParent).showSnackBar(
                SnackBar(content: Text('تم حذف المنتج بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true)
                  .pop(); // Close dialog
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
            } else if (state is DeleteProductByIdFromStoreFailure) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
          builder: (dialogContext, state) {
            return CustomShowDialogForViewWidget(
              title: 'حذف المنتج',
              subtitle: 'هل تريد بالتأكيد حذف هذا المنتج؟',
              isLoading: state is DeleteProductByIdFromStoreLoading,
              onConfirm: () =>
                  deleteProductCubit.deleteProductById(productId: productId),
              confirmText: 'حذف',
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
              ScaffoldMessenger.of(contextParent).showSnackBar(
                SnackBar(content: Text('تم إعادة تنشيط المنتج بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true)
                  .pop(); // Close dialog
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
                  ? 'هل انت متأكد من إيقاف المنتجات؟'
                  : 'إعادة تنشيط المنتج',
              subtitle: ids.length > 1
                  ? 'عدد المنتجات التي تريد إيقافها : ${ids.length}'
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

void showGetProductDetailsDialog({
  required BuildContext contextParent,
  required ProductDetailsCubit productDetailsCubit,
}) {
  showDialog(
    context: contextParent,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: productDetailsCubit,
        child: BlocListener<ProductDetailsCubit, ProductDetailsState>(
            listener: (dialogContext, state) {
              if (state is ProductDetailsSuccess) {
                Navigator.of(dialogContext, rootNavigator: true).pop();
                contextParent.push(
                  AppRouter.storeRouters.kStoreEditProduct,
                  extra: EditProductExtraData(
                    productDetails: state.productDetailsEntity,
                    onSuccess: () {
                      final cubitGetStoreProducts =
                          contextParent.read<GetStoreProductsWithFilterCubit>();
                      cubitGetStoreProducts.getStoreProductsWitheFilter(
                        storeProductsFilter:
                            cubitGetStoreProducts.currentStoreProductsFilter ??
                                0,
                        categoryId: cubitGetStoreProducts.currentMainCategoryId,
                        pageNumber: 1,
                        pageSize: 100,
                      );
                    },
                  ),
                );
              } else if (state is ProductDetailsFailure) {
                Navigator.of(dialogContext, rootNavigator: true).pop();
                debugPrint(
                    "=============  فشل في جلب بيانات المنتج  ==============");
                debugPrint(state.errMessage);
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(content: Text(state.errMessage)),
                );
              }
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Padding for content
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Ensures the dialog sizes based on content
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 25.0,
                      height: 25.0,
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "جاري جلب بيانات المنتج...",
                      style: KTextStyle.textStyle18,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )),
      );
    },
  );
}
