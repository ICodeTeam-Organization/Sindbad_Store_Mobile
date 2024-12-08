import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/custom_delete_dialog_widget.dart';
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
    // context
    //     .read<GetStoreProductsWithFilterCubit>()
    //     .getStoreProductsWitheFilter(storeProductsFilter, 1, 10);

    // جميغ المنتجات
   if (storeProductsFilter == 0) {
      context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,false ,false);
   }
   //  المنتجات التي عليها عروض
   else if(storeProductsFilter ==1){
     context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,true ,false);
   }
   //  المنتجات الموقوفة  
   else if(storeProductsFilter ==2){
     context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,false ,true);
   }
    return BlocConsumer<GetStoreProductsWithFilterCubit,
        GetStoreProductsWithFilterState>(
      listener: (context, state) {
        print(
            "====================  Current state: $state  ============================"); // تتبع الحالة الحالية
        if (state is DeleteStoreProductByIdSuccess) {
          // عرض رسالة نجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.message)),
          );

          // تحديث قائمة المنتجات بعد الحذف
            // جميغ المنتجات
   if (storeProductsFilter == 0) {
      context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,false ,false);
   }
   //  المنتجات التي عليها عروض
   else if(storeProductsFilter ==1){
     context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,true ,false);
   }
   //  المنتجات الموقوفة  
   else if(storeProductsFilter ==2){
     context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,false ,true);
   }
          // context
          //     .read<GetStoreProductsWithFilterCubit>()
          //     .getStoreProductsWitheFilter(
          //       storeProductsFilter,
          //       1, // الصفحة الأولى
          //       10, // الحجم
          //     );
        }

        if (state is DeleteStoreProductByIdFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
          // تحديث قائمة المنتجات بعد فشل الحذف
            // جميغ المنتجات
   if (storeProductsFilter == 0) {
      context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,false ,false);
   }
   //  المنتجات التي عليها عروض
   else if(storeProductsFilter ==1){
     context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,true ,false);
   }
   //  المنتجات الموقوفة  
   else if(storeProductsFilter ==2){
     context
        .read<GetStoreProductsWithFilterCubit>()
        .getStoreProductsWitheFilter(storeProductsFilter, 1, 10 ,false ,true);
   }
          // context
          //     .read<GetStoreProductsWithFilterCubit>()
          //     .getStoreProductsWitheFilter(
          //       storeProductsFilter,
          //       1, // الصفحة الأولى
          //       10, // الحجم

          //     );
          print({state.errMessage});
        }
      },
      builder: (context, state) {
        if (state is GetStoreProductsWithFilterLoading ||
            state is DeleteStoreProductByIdLoading) {
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
                    TwoButtonInsideListViewProducts(
                      onTapEdit: () {
                        // state.products //  ===> this pass contains [productid,productName,productNumber,productPrice,productImageUrl]
                        // تنفيذ التعديل
                        context.push(AppRouter.storeRouters.kStoreEditProduct,
                            extra: 1 // here pass the product id
                            );
                      },
                      onTapDelete: () {
                        showDialog(
                          context: context, // تمرير السياق الصحيح
                          builder: (BuildContext dialogContext) {
                            return CustomDeleteDialogWidget(
                              title: 'هل انت متأكد من الحذف ؟',
                              subtitle: 'رقم المنتج :  ${product.productid}',
                              onConfirm: () {
                                // استخدام السياق الأب للوصول إلى cubit
                                context
                                    .read<GetStoreProductsWithFilterCubit>()
                                    .deleteProductById(
                                        productId: product.productid!);
                                print(
                                    "productid =========>  ${product.productid.toString()}");

                                // إغلاق مربع الحوار
                                Navigator.of(dialogContext).pop();
                              },
                            );
                          },
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
