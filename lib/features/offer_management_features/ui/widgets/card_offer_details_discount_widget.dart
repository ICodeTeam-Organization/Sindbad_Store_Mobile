import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/core/utils/currancy.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/text_discount_prices_widget.dart';

class CardOfferDetailsDiscountWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final num lastPrice;
  final num newPrice;
  const CardOfferDetailsDiscountWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.lastPrice,
      required this.newPrice});

  @override
  State<CardOfferDetailsDiscountWidget> createState() =>
      _CardOfferDetailsDiscountWidgetState();
}

class _CardOfferDetailsDiscountWidgetState
    extends State<CardOfferDetailsDiscountWidget> {
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    bool ifSmallScreen = widthScreen == 360;
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
                    width: ifSmallScreen ? 80.w : 100.w,
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
                  TextDiscountPricesWidget(
                    title: 'قبل الخصم',
                    content:
                        "${widget.lastPrice.toStringAsFixed(0)} ${Currancy.currency}",
                    isBeforeDiscount: true,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  TextDiscountPricesWidget(
                    title: 'بعد الخصم',
                    content:
                        "${widget.newPrice.toStringAsFixed(0)} ${Currancy.currency}",
                    isBeforeDiscount: false,
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
