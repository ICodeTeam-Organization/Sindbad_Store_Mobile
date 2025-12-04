import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/check_box_custom.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/image_card_custom.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/two_button_inside_list_view_products.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.products,
    required this.isEven,
    required this.product,
    this.selected = false,
    this.onToggleSelection,
  });

  final List<ProductEntity> products;
  final bool isEven;
  final ProductEntity product;
  final bool selected;
  final void Function(int productId)? onToggleSelection;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            margin: 0 + 1 == products.length
                ? EdgeInsets.only(bottom: 100.h)
                : null,
            padding: EdgeInsets.only(top: 26.h, bottom: 26.h, left: 10.w),
            decoration: BoxDecoration(
              color: isEven ? AppColors.background : Colors.white,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              children: [
                CheckBoxCustom(
                  val: selected,
                  onChanged: (val) {
                    if (onToggleSelection != null) {
                      onToggleSelection!(product.id);
                    } else {
                      // Fallback to legacy method
                      context
                          .read<ProductsCubit>()
                          .toggleProductSelection(product.id);
                    }
                  },
                ),
                ImageCardCustom(imageUrlNetwork: product.imageUrl!),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        textAlign: TextAlign.right,
                        style: TextTheme.of(context).titleMedium,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'رقم المنتج: ${product.number ?? ''}',
                        textAlign: TextAlign.right,
                        style: TextTheme.of(context).bodySmall,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'السعر: ${product.price ?? ''} ريال',
                        textAlign: TextAlign.right,
                        style: TextTheme.of(context).bodySmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                TwoButtonInsideListViewProducts(
                  onTapEdit: () {
                    // context
                    //     .read<ProductDetailsCubit>()
                    //     .getProductDetails(productId: product.productId!);
                    // showGetProductDetailsDialog(
                    //   contextParent: context,
                    //   productDetailsCubit: context.read<ProductDetailsCubit>(),
                    // );
                  },
                  //   reactivate: widget.storeProductsFilter == 2,
                  onTapDeleteOrReactivate: () {
                    // widget.storeProductsFilter == 2
                    //     ? showActivateOneOrMoreProductsDialog(
                    //         contextParent: context,
                    //         ids: [product.productId!],
                    //         storeProductsFilter:
                    //             widget.storeProductsFilter,
                    //         activateProductsCubit: context.read<
                    //             ActivateProductsByIdsCubit>(),
                    //       )
                    //     : showDeleteProductDialog(
                    //         contextParent: context,
                    //         productId: product.productId!,
                    //         storeProductsFilter:
                    //             widget.storeProductsFilter,
                    //         deleteProductCubit: context.read<
                    //             DeleteProductByIdFromStoreCubit>(),
                    //       );
                  },
                  reactivate: 0 == 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
