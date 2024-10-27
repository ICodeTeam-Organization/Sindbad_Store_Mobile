import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/custom_text.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/image_product.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/product_name.dart';

class StoreOrderProcessingListViewBody extends StatelessWidget {
  const StoreOrderProcessingListViewBody(
      {super.key,
      required this.orderNum,
      required this.imageCode,
      required this.productName,
      required this.quantity,
      required this.price,
      required this.totalPrice,
      required this.totalQuantity,
      required this.imageProduct});
  final String orderNum;
  final String imageCode;
  final String productName;
  final String quantity;
  final String price;
  final String totalPrice;
  final String totalQuantity;
  final String imageProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370.w,
      height: 400.h,
      child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: 10,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.only(right: 5.w),
              margin: EdgeInsets.symmetric(vertical: 5.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: const Offset(-1, 1),
                        blurRadius: 1.r)
                  ]),
              width: 370.w,
              height: 130.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // رقم المنتج
                      Container(
                          width: 200.w,
                          alignment: Alignment.center,
                          child: Text(
                            orderNum,
                            style: KTextStyle.secondaryTitle,
                          )),
                      SizedBox(
                        height: 7.h,
                      ),
                      //  صورة الباركود
                      Image.asset(
                        imageCode,
                        height: 23.h,
                        width: 210.w,
                        fit: BoxFit.fill,
                      ),
                      // اسم المنتج
                      ProductName(productName: productName),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'الكمية: ',
                          ),
                          CustomText(
                            text: quantity,
                          ),
                          SizedBox(
                            width: 50.w,
                          ),
                          const CustomText(
                            text: 'السعر: ',
                          ),
                          Text(price,
                              style: KTextStyle.secondaryTitle
                                  .copyWith(color: AppColors.redColor)),
                        ],
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                        children: [
                          const CustomText(
                            text: 'الاجمالي: ',
                          ),
                          Text(totalPrice,
                              style: KTextStyle.secondaryTitle
                                  .copyWith(color: AppColors.redColor)),
                          SizedBox(
                            width: 50.w,
                          ),
                          CustomText(
                            text: totalQuantity,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  // صورة المنتج
                  ImageProduct(imageProduct: imageProduct),
                ],
              ),
            );
          }),
    );
  }
}
