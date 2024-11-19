import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CardOfferProductDetailsWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final String lastPrice;
  final String newPrice;
  const CardOfferProductDetailsWidget({super.key, required this.productName, required this.productImage, required this.lastPrice, required this.newPrice});

  @override
  State<CardOfferProductDetailsWidget> createState() => _CardOfferProductDetailsWidgetState();
}

class _CardOfferProductDetailsWidgetState extends State<CardOfferProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: AppColors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.h,
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            widget.productImage,
                            width: 45.w,
                            height: 45.w,
                          ),
                          SizedBox(width: 10,),
                          Text(widget.productName,style: KTextStyle.textStyle14.copyWith(color: AppColors.blackLight,),),
                        ]
                      ),
                      Row(
                        children: [
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text('قبل الخصم',style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                          SizedBox(height: 15,),
                          Text(widget.lastPrice,style: KTextStyle.textStyle13.copyWith(color: AppColors.greyDark, decoration: TextDecoration.lineThrough,),),
                            ],
                          ),
                          SizedBox(width: 15,),
                          Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text('بعد الخصم',style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                          SizedBox(height: 15,),
                          Text(widget.newPrice,style: KTextStyle.textStyle13.copyWith(color: AppColors.primary,),),
                            ],
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}