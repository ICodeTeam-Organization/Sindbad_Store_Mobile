import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CardOfferProductDetailsDiscountWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final num lastPrice;
  final num newPrice;
  const CardOfferProductDetailsDiscountWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.lastPrice,
      required this.newPrice});

  @override
  State<CardOfferProductDetailsDiscountWidget> createState() =>
      _CardOfferProductDetailsDiscountWidgetState();
}

class _CardOfferProductDetailsDiscountWidgetState
    extends State<CardOfferProductDetailsDiscountWidget> {
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Image.network(
                    widget.productImage,
                    width: 45.w,
                    height: 45.w,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Image.asset(
                        'assets/default_image.png',
                        width: 45.w,
                        height: 45.w,
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                          width: 45.w,
                          height: 45.w,
                          'assets/default_image.png'); // Local fallback
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 125.w,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            Text(
                              widget.productName,
                              style: KTextStyle.textStyle14.copyWith(
                                color: AppColors.blackLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]),
                Row(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'قبل الخصم',
                        style: KTextStyle.textStyle11.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "\$ ${widget.lastPrice.toStringAsFixed(0)}",
                        style: KTextStyle.textStyle13.copyWith(
                          color: AppColors.greyDark,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'بعد الخصم',
                        style: KTextStyle.textStyle11.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "\$ ${widget.newPrice.toStringAsFixed(0)}",
                        style: KTextStyle.textStyle13.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
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
