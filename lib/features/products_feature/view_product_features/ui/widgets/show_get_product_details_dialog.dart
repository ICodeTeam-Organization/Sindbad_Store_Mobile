// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:sindbad_management_app/config/routers/routers_names.dart';
// import 'package:sindbad_management_app/core/swidgets/no_data_widget.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import '../../../../../config/styles/Colors.dart';
// import '../../../../../config/styles/text_style.dart';
// import '../../../add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
// import '../../../add_and_edit_product_feature/ui/screens/edit_product_screen.dart';
// import '../../domain/entities/product_entity.dart';
// import '../manager/activate_products/activate_products_by_ids_cubit.dart';
// import '../manager/delete_product_by_id_from_store/delete_product_by_id_from_store_cubit.dart';
// import '../manager/products_cubit/products_cubit.dart';
// import 'check_box_custom.dart';
// import 'custom_show_dialog_for_view_widget.dart';
// import 'image_card_custom.dart';
// import 'shimmer_for_products_with_filter.dart';
// import 'two_button_inside_list_view_products.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/screens/edit_product_screen.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';

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
                  AppRoutes.editProduct,
                  extra: EditProductExtraData(
                    productDetails: state.productDetailsEntity,
                    onSuccess: () {
                      final cubitGetStoreProducts =
                          contextParent.read<ProductsCubit>();
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
