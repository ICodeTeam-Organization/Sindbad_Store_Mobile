import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_feature/modify_offer_feature/ui/widgets/product_discount_tile_widget.dart';

class CardProductDiscountWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final num oldPrice;
  final num newPrice;
  final num discountRate;
  final void Function()? onTapQuit;
  final ValueNotifier<int> discountRateNotifier;

  const CardProductDiscountWidget({
    super.key,
    required this.productName,
    required this.productImage,
    required this.oldPrice,
    required this.newPrice,
    required this.discountRate,
    this.onTapQuit,
    required this.discountRateNotifier,
  });

  @override
  State<CardProductDiscountWidget> createState() =>
      _CardProductDiscountWidgetState();
}

class _CardProductDiscountWidgetState extends State<CardProductDiscountWidget> {
  late TextEditingController discountRateController;
  late TextEditingController newPriceController;

  @override
  void initState() {
    super.initState();
    discountRateController = TextEditingController(
        text: widget.discountRate.clamp(1, 100).toStringAsFixed(0));
    newPriceController = TextEditingController(
        text: widget.newPrice.clamp(1, widget.oldPrice - 1).toStringAsFixed(0));

    // Listen to parent changes
    widget.discountRateNotifier.addListener(() {
      setState(() {
        int newRate = widget.discountRateNotifier.value.clamp(1, 100);
        discountRateController.text = newRate.toString();
        _updateNewPrice(newRate);
      });
    });
  }

  @override
  void dispose() {
    discountRateController.dispose();
    newPriceController.dispose();
    super.dispose();
  }

  /// Updates new price based on the discount rate
  void _updateNewPrice(int discountRate) {
    double newPrice =
        widget.oldPrice - (widget.oldPrice * (discountRate / 100));
    newPriceController.text =
        newPrice.clamp(1, widget.oldPrice - 1).toStringAsFixed(0);
  }

  /// Updates discount rate based on the new price
  void _updateDiscountRate(num newPrice) {
    double discountRate =
        ((widget.oldPrice - newPrice) / widget.oldPrice) * 100;
    int newDiscountRate = discountRate.clamp(1, 100).toInt();
    discountRateController.text = newDiscountRate.toString();
  }

  /// Handle changes in the discount rate input field
  void _onDiscountRateChanged(String value) {
    int discountRate = int.tryParse(value) ?? 1;
    discountRate = discountRate.clamp(1, 100);
    setState(() {
      _updateNewPrice(discountRate);
    });
  }

  /// Handle changes in the new price input field
  void _onNewPriceChanged(String value) {
    num newPrice = num.tryParse(value) ?? 1;
    newPrice = newPrice.clamp(1, widget.oldPrice - 1);
    setState(() {
      _updateDiscountRate(newPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.sizeOf(context).width;
    bool ifSmallScreen = widthScreen == 360;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            color: AppColors.primaryBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              widget.productImage,
                              width: 45.w,
                              height: 45.w,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
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
                                  'assets/default_image.png',
                                ); // Local fallback
                              },
                            ),
                            SizedBox(width: 10),
                            Text(
                              widget.productName,
                              style: KTextStyle.textStyle14.copyWith(
                                color: AppColors.blackLight,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: widget.onTapQuit,
                          child: Icon(
                            Icons.close,
                            color: AppColors.greyIcon,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Discount Percentage Input
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: ProductDiscountTileWidget(
                      title: 'نسبة الخصم ',
                      controller: discountRateController,
                      isEnable: true,
                      isPrice: false,
                      onChanged: (value) {
                        if (value.isEmpty) {
                          discountRateController.text = '1';
                          _onDiscountRateChanged('1');
                        } else {
                          final int? number = int.tryParse(value);
                          if (number != null && number >= 1 && number <= 99) {
                            _onDiscountRateChanged(value);
                          }
                        }
                      },
                    ),
                  ),
                  // Previous and New Price Display
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: ifSmallScreen ? 125.w : 150.w,
                    child: Column(
                      children: [
                        // Last Price
                        ProductDiscountTileWidget(
                          title: 'السعر السابق',
                          controller: TextEditingController(
                              text: widget.oldPrice.toStringAsFixed(0)),
                          isEnable: false,
                        ),
                        // New Price
                        ProductDiscountTileWidget(
                          title: 'السعر النهائي',
                          controller: newPriceController,
                          isEnable: true,
                          onChanged: (value) {
                            final int? number = int.tryParse(value);
                            if (value.isEmpty) {
                              newPriceController.text = '1';
                              _onNewPriceChanged('1');
                            } else if (number != null &&
                                number >= 1 &&
                                number <= widget.oldPrice - 1) {
                              _onNewPriceChanged(value);
                            }
                          },
                          oldPrice: widget.oldPrice,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
