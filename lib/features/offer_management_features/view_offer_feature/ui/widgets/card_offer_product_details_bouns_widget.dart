import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CardOfferProductDetailsBounsWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final num numberToBuy;
  final num numberToGet;
  const CardOfferProductDetailsBounsWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.numberToBuy,
      required this.numberToGet});

  @override
  State<CardOfferProductDetailsBounsWidget> createState() =>
      _CardOfferProductDetailsBounsWidgetState();
}

class _CardOfferProductDetailsBounsWidgetState
    extends State<CardOfferProductDetailsBounsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 100.h,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.greyBorder)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Image.network(
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
                    widget.numberToBuy.toString(),
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
                    widget.numberToGet.toString(),
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
    );
  }
}
