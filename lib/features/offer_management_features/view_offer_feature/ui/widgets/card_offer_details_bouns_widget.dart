import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/text_flexible_widget.dart';

class CardOfferDetailsBounsWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final num numberToBuy;
  final num numberToGet;
  const CardOfferDetailsBounsWidget(
      {super.key,
      required this.productName,
      required this.productImage,
      required this.numberToBuy,
      required this.numberToGet});

  @override
  State<CardOfferDetailsBounsWidget> createState() =>
      _CardOfferDetailsBounsWidgetState();
}

class _CardOfferDetailsBounsWidgetState
    extends State<CardOfferDetailsBounsWidget> {
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
                  TextFlexibleWidget(
                    title: 'يشتري ',
                    colorTitle: AppColors.greyDark,
                  ),
                  TextFlexibleWidget(
                    title: widget.numberToBuy.toString(),
                    colorTitle: AppColors.primary,
                  ),
                  TextFlexibleWidget(
                    title: ' يحصل على ',
                    colorTitle: AppColors.greyDark,
                  ),
                  TextFlexibleWidget(
                    title: widget.numberToGet.toString(),
                    colorTitle: AppColors.primary,
                  ),
                  TextFlexibleWidget(
                    title: ' مجاني',
                    colorTitle: AppColors.greyDark,
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
