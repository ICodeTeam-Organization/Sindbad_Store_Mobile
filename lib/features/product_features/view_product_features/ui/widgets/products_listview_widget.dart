import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/setup_service_locator.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/utils/route.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/delete_product_by_id_use_case.dart';
import '../manager/delete_product_by_id_from_store/delete_product_by_id_from_store_cubit.dart';
import '../manager/disable_products/cubit/disable_products_by_ids_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'check_box_custom.dart';
import 'custom_show_dialog_for_view_widget.dart';
import 'image_card_custom.dart';
import 'shimmer_for_products_with_filter.dart';
import 'text_style_detials.dart';
import 'two_button_inside_list_view_products.dart';

class ProductsListView extends StatelessWidget {
  final int storeProductsFilter;
  const ProductsListView({
    super.key,
    required this.storeProductsFilter,
  });

  @override
  Widget build(BuildContext context) {
    final cubitGetStoreProducts =
        context.read<GetStoreProductsWithFilterCubit>();
    // final cubitDisableProducts =
    //     context.read<DisableProductsByIdsCubit>();

    // جميغ المنتجات  =  0
    //  المنتجات التي عليها عروض  =  1
    //  المنتجات الموقوفة  =  2
    cubitGetStoreProducts.getStoreProductsWitheFilter(
        storeProductsFilter: storeProductsFilter, pageNumper: 1, pageSize: 100);

    return BlocConsumer<GetStoreProductsWithFilterCubit,
        GetStoreProductsWithFilterState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetStoreProductsWithFilterLoading) {
          return ShimmerForProductsWithFilter();
        } else if (state is GetStoreProductsWithFilterSuccess) {
          final List<ProductEntity> products = state.products;

          return products.isEmpty
              ? Center(child: Text("لا يوجد منتجات"))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    ProductEntity product = products[index];
                    bool isEven = index % 2 == 0;
                    return Container(
                      padding:
                          EdgeInsets.only(top: 26.h, bottom: 26.h, left: 10.w),
                      decoration: BoxDecoration(
                        color: isEven ? AppColors.background : Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CheckBoxCustom(
                            val: state.checkedStates[index],
                            onChanged: (val) {
                              cubitGetStoreProducts.updateCheckboxState(
                                  index, val!, product.productid!);
                            },
                          ),
                          ImageCardCustom(
                            imageUrlnetwork: product.productImageUrl!,
                          ), // افترض أن لديك Card مخصص لعرض الصور
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
                              // state.products //  ===> this pass contains [productid,productName,productNumber,productPrice,productImageUrl]
                              // تنفيذ التعديل
                              context.push(
                                  AppRouter.storeRouters.kStoreEditProduct,
                                  extra: 1 // here pass the product id
                                  );
                            },
                            onTapDelete: () {
                              showDeleteDialog(
                                contextPerant: context,
                                productId: product.productid!,
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

void showDeleteDialog({
  required BuildContext contextPerant,
  required int productId,
  required int storeProductsFilter,
  required DeleteProductByIdFromStoreCubit
      deleteProductCubit, // Add this parameter
}) {
  showDialog(
    context: contextPerant,
    builder: (BuildContext dialogContext) {
      return BlocProvider.value(
        value: deleteProductCubit, // Provide the cubit explicitly
        child: BlocConsumer<DeleteProductByIdFromStoreCubit,
            DeleteProductByIdFromStoreState>(
          listener: (dialogContext, state) {
            if (state is DeleteProductByIdFromStoreSuccess) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(content: Text('تم حذف المنتج بنجاح!')),
              );
              Navigator.of(dialogContext, rootNavigator: true)
                  .pop(); // Close dialog
              contextPerant
                  .read<GetStoreProductsWithFilterCubit>()
                  .getStoreProductsWitheFilter(
                    storeProductsFilter: storeProductsFilter,
                    pageNumper: 1,
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
              onConfirm: () => dialogContext
                  .read<DeleteProductByIdFromStoreCubit>()
                  .deleteProductById(productId: productId),
              confirmText: 'نعم',
              cancelText: 'لا',
            );
          },
        ),
      );
    },
  );
}


// void showDeleteDialog(
//     {required BuildContext contextPerant,
//     required int productId,
//     required int storeProductsFilter}) {
//   showDialog(
//     context: contextPerant,
//     builder: (BuildContext contextPerant) {
//       return BlocConsumer<DeleteProductByIdFromStoreCubit,
//           DeleteProductByIdFromStoreState>(listener: (context, state) {
//         if (state is DeleteProductByIdFromStoreSuccess) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('تم حذف  المنتج بنجاح!')),
//           );
//           Navigator.of(context, rootNavigator: true).pop(); // Close dialog
//           contextPerant
//               .read<GetStoreProductsWithFilterCubit>()
//               .getStoreProductsWitheFilter(
//                 storeProductsFilter: storeProductsFilter,
//                 pageNumper: 1,
//                 pageSize: 100,
//               );
//         } else if (state is DeleteProductByIdFromStoreFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(state.errMessage)),
//           );
//         }
//       }, builder: (context, state) {
//         final cubitDeleteProductById =
//             contextPerant.read<DeleteProductByIdFromStoreCubit>();
//         return CustomShowDialogForViewWidget(
//           title: 'حذف المنتج',
//           subtitle: 'هل تريد بالتأكيد حذف هذا المنتج؟',
//           isLoading: state is DeleteProductByIdFromStoreLoading,
//           onConfirm: () =>
//               cubitDeleteProductById.deleteProductById(productId: productId),
//           confirmText: 'نعم',
//           cancelText: 'لا',
//         );
//       });
//     },
//   );
// }
