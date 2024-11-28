import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/styles/Colors.dart';
import '../../domain/entities/product_entity.dart';
import '../manager/cubit/cubit/get_store_products_with_filter_cubit.dart';
import 'button_custom.dart';
import 'image_card_custom.dart';
import 'text_style_detials.dart';

class ProductsListView extends StatelessWidget {
  final List<ProductEntity> products;
  final void Function(bool?, int) onChanged; // أضف index
  final List<bool> checkedStates;
  final void Function() onTapEdit;
  final void Function() onTapDelete;

  const ProductsListView({
    super.key,
    required this.products,
    required this.onChanged,
    required this.checkedStates,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(1, 1, 10);
    return BlocBuilder<GetStoreProductsWithFilterCubit,
        GetStoreProductsWithFilterState>(
      builder: (context, state) {
        if (state is GetStoreProductsWithFilterLoading) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                        color: Colors.white,
                        height: 130.h,
                        width: MediaQuery.of(context).size.width,
                      ),
                    );
                  }));
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Transform.scale(
                        scale: 0.8, // هنا يمكنك تعديل القيمة حسب الحجم المطلوب
                        child: Checkbox(
                          value: state.checkedStates[index],
                          onChanged: (val) {
                            context
                                .read<GetStoreProductsWithFilterCubit>()
                                .updateCheckboxState(index, val!);
                          },
                          activeColor: AppColors.redDark,
                          checkColor: AppColors.white,
                          side: BorderSide(
                            color: Colors.red,
                            width: 1.0.w,
                          ),
                        ),
                      ),
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
                    Column(
                      children: [
                        CustomButton(
                            text: 'تعديل',
                            icon: Icons.edit,
                            onPressed: onTapEdit),
                        SizedBox(height: 5.h),
                        CustomButton(
                            text: 'حذف',
                            icon: Icons.delete,
                            onPressed: onTapDelete),
                      ],
                    ),
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
