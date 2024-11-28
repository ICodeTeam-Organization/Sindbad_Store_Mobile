import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CardOfferProductDetailsBounsWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final int buysCount;
  final int freesCount;
  const CardOfferProductDetailsBounsWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.buysCount,
      required this.freesCount});

  @override
  State<CardOfferProductDetailsBounsWidget> createState() =>
      _CardOfferProductDetailsBounsWidgetState();
}

class _CardOfferProductDetailsBounsWidgetState
    extends State<CardOfferProductDetailsBounsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.greyBorder),
        color: AppColors.transparent,
      ),
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
                  Row(children: [
                    Image.asset(
                      widget.productImage,
                      width: 45.w,
                      height: 45.w,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.productName,
                      style: KTextStyle.textStyle14.copyWith(
                        color: AppColors.blackLight,
                      ),
                    ),
                  ]),
                  Row(children: [
                    Text(
                      'يشتري ',
                      style: KTextStyle.textStyle12.copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                    Text(
                      widget.buysCount.toString(),
                      style: KTextStyle.textStyle12.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      ' يحصل على ',
                      style: KTextStyle.textStyle12.copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                    Text(
                      widget.freesCount.toString(),
                      style: KTextStyle.textStyle12.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      ' مجاني',
                      style: KTextStyle.textStyle12.copyWith(
                        color: AppColors.greyDark,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
