import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/core/dialogs/delete_confirm_dialog.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/menu_button_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/check_box_custom.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/image_card_custom.dart';

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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    // Theme-aware colors
    final evenBgColor = isDark ? Colors.grey[850] : AppColors.background;
    final oddBgColor = isDark ? Colors.grey[900] : Colors.white;
    final subtitleColor = isDark ? Colors.grey[400]! : Color(0xff636773);
    final priceColor = theme.colorScheme.primary;

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
              color: isEven ? evenBgColor : oddBgColor,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                ImageCardCustom(imageUrlNetwork: product.imageUrl),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name ?? '',
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextTheme.of(context).titleMedium,
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        '${l10n.productNumber} ${product.number ?? ''}',
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        style: TextTheme.of(context).bodySmall!.copyWith(
                            fontWeight: FontWeight.normal,
                            color: subtitleColor,
                            fontSize: 12),
                      ),
                      SizedBox(height: 10.h),
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          style: TextTheme.of(context).bodySmall!.copyWith(
                              fontWeight: FontWeight.normal,
                              color: subtitleColor,
                              fontSize: 12),
                          children: [
                            TextSpan(text: '${l10n.price} '),
                            TextSpan(
                              text: '${product.price ?? ''}',
                              style: TextStyle(color: priceColor),
                            ),
                            TextSpan(text: ' ${l10n.currency}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MenuButtonWidget(
                      title: l10n.edit,
                      iconPath: "assets/update.svg",
                      isSolid: false,
                      onTap: () {
                        context.push(AppRoutes.editProduct, extra: product.id);
                        // context
                        //     .read<ProductDetailsCubit>()
                        //     .getProductDetails(productId: product.id);
                        // showGetProductDetailsDialog(
                        //   contextParent: context,
                        //   productDetailsCubit:
                        //       context.read<ProductDetailsCubit>(),
                        // );
                      },
                    ),
                    SizedBox(height: 5.h),
                    MenuButtonWidget(
                      title: l10n.delete,
                      iconPath: "assets/delete.svg",
                      isSolid: false,
                      onTap: () {
                        showDeleteConfirmDialog(
                          okText: l10n.yesContinueProcess,
                          cancelText: l10n.noCancelOperation,
                          subtitle: l10n.deleteProductPermanent,
                          context: context,
                          title: l10n.deleteProduct,
                          message: l10n.deleteProductConfirm,
                          onConfirm: () {
                            context
                                .read<ProductsCubit>()
                                .deleteProduct(product.id);
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
