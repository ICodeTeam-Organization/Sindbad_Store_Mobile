import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

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
    discountRateController =
        TextEditingController(text: widget.discountRate.toStringAsFixed(0));
    newPriceController =
        TextEditingController(text: widget.newPrice.toStringAsFixed(0));

    // Listen to parent text changes (if provided)
    widget.discountRateNotifier.addListener(() {
      setState(() {
        discountRateController.text =
            widget.discountRateNotifier.value.toStringAsFixed(0);
        _updateNewPrice(double.tryParse(discountRateController.text) ?? 0);
      });
    });
  }

  @override
  void dispose() {
    discountRateController.dispose();
    newPriceController.dispose();
    super.dispose();
  }

  /// Update New Price Based on Discount Rate
  void _updateNewPrice(double discountRate) {
    double newPrice =
        widget.oldPrice - (widget.oldPrice * (discountRate / 100));
    newPriceController.text = newPrice.toStringAsFixed(0);
  }

  /// Update Discount Rate Based on New Price
  void _updateDiscountRate(num newPrice) {
    double discountRate =
        ((widget.oldPrice - newPrice) / widget.oldPrice) * 100;
    discountRateController.text = discountRate.toStringAsFixed(0);
  }

  /// Handle Discount Rate Changes
  void _onDiscountRateChanged(String value) {
    double discountRate = double.tryParse(value) ?? 0;
    setState(() {
      _updateNewPrice(discountRate);
    });
  }

  /// Handle New Price Changes
  void _onNewPriceChanged(String value) {
    num newPrice = num.tryParse(value) ?? widget.oldPrice;
    setState(() {
      _updateDiscountRate(newPrice);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  // Quit Button
                  Positioned(
                    top: 15,
                    left: 0,
                    child: InkWell(
                      onTap: widget.onTapQuit,
                      child: Icon(
                        Icons.close,
                        color: AppColors.greyIcon,
                        size: 15,
                      ),
                    ),
                  ),
                  // Product Information
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Image.network(
                          widget.productImage,
                          width: 45.w,
                          height: 45.w,
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
                  ),
                  // Discount Percentage Input
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Text(
                          'نسبة الخصم ',
                          style: KTextStyle.textStyle9.copyWith(
                            color: AppColors.blackLight,
                          ),
                        ),
                        SizedBox(width: 10.h),
                        SizedBox(
                          height: 30.h,
                          width: 80.w,
                          child: TextFormField(
                            style: KTextStyle.textStyle9.copyWith(
                              color: AppColors.blackLight,
                            ),
                            controller: discountRateController,
                            onChanged: _onDiscountRateChanged,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.white,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 4.h,
                                horizontal: 4.w,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 4.w, right: 4.w),
                                child: Icon(
                                  Icons.percent,
                                  color: AppColors.greyLight,
                                  size: 16,
                                ),
                              ),
                              prefixIconConstraints: BoxConstraints(
                                minWidth: 16.w,
                                minHeight: 16.h,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.greyBorder,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Previous and New Price Display
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: 150.w,
                    child: Column(
                      children: [
                        // Last Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'السعر السابق',
                              style: KTextStyle.textStyle9.copyWith(
                                color: AppColors.blackLight,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 30.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.oldPrice.toStringAsFixed(0),
                                    style: KTextStyle.textStyle10.copyWith(
                                      color: AppColors.blackLight,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Icon(
                                    Icons.attach_money,
                                    color: AppColors.greyLight,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        // New Price
                        Row(
                          children: [
                            Text(
                              'السعر النهائي',
                              style: KTextStyle.textStyle9.copyWith(
                                color: AppColors.blackLight,
                              ),
                            ),
                            SizedBox(width: 10.h),
                            SizedBox(
                              height: 30.h,
                              width: 80.w,
                              child: TextFormField(
                                style: KTextStyle.textStyle10.copyWith(
                                  color: AppColors.primary,
                                ),
                                controller: newPriceController,
                                onChanged: _onNewPriceChanged,
                                textAlign: TextAlign.end,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 4.w),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: AppColors.greyLight,
                                      size: 15,
                                    ),
                                  ),
                                  suffixIconConstraints: BoxConstraints(
                                    minWidth: 16.w,
                                    minHeight: 16.h,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 4.h,
                                    horizontal: 4.w,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.greyBorder,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
