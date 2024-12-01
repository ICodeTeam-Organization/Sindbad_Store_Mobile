import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/utils/route.dart';
import '../../domain/entities/product_entity.dart';
import '../manager/cubit/cubit/get_store_products_with_filter_cubit.dart';
import 'check_box_custom.dart';
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
    context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10);
    return BlocBuilder<GetStoreProductsWithFilterCubit,
        GetStoreProductsWithFilterState>(
      builder: (context, state) {
        if (state is GetStoreProductsWithFilterLoading) {
          return ShimmerForProductsWithFilter();
        } else if (state is GetStoreProductsWithFilterSuccess) {
          return ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              ProductEntity product = state.products[index];
              bool isEven = index % 2 == 0;
              return Container(
                padding: EdgeInsets.only(top: 26.h, bottom: 26.h, left: 10.w),
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
                        context
                            .read<GetStoreProductsWithFilterCubit>()
                            .updateCheckboxState(index, val!,
                                state.products[index].productNumber!);
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
                    TwoButtonInsideListViewProducts(onTapEdit: () {
                      // state.products //  ===> this pass contains [productid,productName,productNumber,productPrice,productImageUrl]
                      // تنفيذ التعديل
                      context.push(AppRouter.storeRouters.kStoreEditProduct,
                          extra: 1 // here pass the product id
                          );
                    }, onTapDelete: () {
                      // تنفيذ الحذف
                    }),
                  ],
                ),
              );
            },
          );
        } else if (state is GetStoreProductsWithFilterFailure) {
          return Center(child: Text(state.errMessage));
        } else {
          return Text("=======BAGAR====");
        }
      },
    );
  }
}
