import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
class StoreOrderProcessingListViewWidget extends StatelessWidget {
  const StoreOrderProcessingListViewWidget({super.key, required this.idOrder, required this.imageCode,required this.productName, required this.quantity, required this.price, required this.totalPrice, required this.totalQuantity, required this.imageProduct});
  final String idOrder;
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
        itemBuilder: (context,i){
          return Container(
            padding: EdgeInsets.only(right: 5.w),
            margin:  EdgeInsets.symmetric(vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: AppColors.primaryColor,
              boxShadow:  [BoxShadow(
                  color: Colors.grey,
                  offset: const Offset(-1, 1),
                  blurRadius: 1.r
                )]
            ),
            width: 370.w,
            height: 130.h,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200.w,
                      alignment: Alignment.center,
                      child:Text(idOrder,style: KTextStyle.secondaryTitle,)),

                      SizedBox(
                        height: 7.h,
                      ),

                    Image.asset(imageCode, height: 23.h,width: 210.w,fit: BoxFit.fill,),

                    SizedBox(
                      width: MediaQuery.of(context).size.width *.6,
                      height: 35.h,
                      child:Text(productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: KTextStyle.secondaryTitle,)),

                      SizedBox(
                        height: 7.h,
                      ),
                      Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("الكمية: ",style: KTextStyle.secondaryTitle,),
                        Text(quantity,style: KTextStyle.secondaryTitle.copyWith(color: AppColors.redColor),),
                        SizedBox(width: 50.w,),
                        Text("السعر: ",style: KTextStyle.secondaryTitle),
                        Text(price,style: KTextStyle.secondaryTitle.copyWith(color: AppColors.redColor)),

                      ],
                    ),
                    SizedBox(
                        height: 7.h,
                      ),
                    Row(
                      children: [
                        Text("الاجمالي: ",style: KTextStyle.secondaryTitle),
                        Text(totalPrice,style: KTextStyle.secondaryTitle.copyWith(color: AppColors.redColor)),
                        SizedBox(width: 50.w,),
                        Text(totalQuantity,style: KTextStyle.secondaryTitle),

                      ],
                    ),
                    
                  ],
                ),
                SizedBox(
                        height: 7.h,
                      ),
                      AspectRatio(
                        aspectRatio: .88,
                        child: Image.asset(imageProduct,
                        width: MediaQuery.of(context).size.width * .36,
                        height: 140.h,
                        fit: BoxFit.fill,
                        ),
                          ),
                // Container(
                //   width: MediaQuery.of(context).size.width * .36,
                //   height: 140.h,
                //   padding: EdgeInsets.symmetric(vertical: 5.h),
                //   child: Image.asset(imageProduct,width: 140.w, height: 140.h,fit: BoxFit.cover,))
              ],
            ),
          );
        }
        
        ),
    );
  }
}