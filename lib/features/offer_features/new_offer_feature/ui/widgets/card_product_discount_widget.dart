import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CardProductDiscountWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final int lastPrice;
  final double newPrice;
  final double discountRate;
  final void Function()? onTapQuit;
  const CardProductDiscountWidget({
    super.key,
    required this.productName,
    required this.productImage,
    required this.lastPrice,
    required this.newPrice,
    required this.discountRate,
    this.onTapQuit,
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
        TextEditingController(text: widget.discountRate.toString());
    newPriceController =
        TextEditingController(text: widget.newPrice.toString());
  }

  // Method to handle the discount rate change
  void _onDiscountRateChanged(String value) {
    double discountRate = double.tryParse(value) ?? 0;
    double newPrice =
        widget.lastPrice - (widget.lastPrice * (discountRate / 100));
    setState(() {
      newPriceController.text = newPrice.toStringAsFixed(2);
    });
  }

  // Method to handle the new price change
  void _onNewPriceChanged(String value) {
    double newPrice = double.tryParse(value) ?? 0;
    double discountRate =
        ((widget.lastPrice - newPrice) / widget.lastPrice) * 100;
    setState(() {
      discountRateController.text = discountRate.toStringAsFixed(2);
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
                  Positioned(
                    top: 0,
                    right: 0,
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
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Text(
                          'نسبة الخصم ',
                          style: KTextStyle.textStyle10.copyWith(
                            color: AppColors.blackLight,
                          ),
                        ),
                        SizedBox(
                          width: 10.h,
                        ),
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    width: 150.w,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'السعر السابق',
                              style: KTextStyle.textStyle10.copyWith(
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
                                    widget.lastPrice.toString(),
                                    style: KTextStyle.textStyle10.copyWith(
                                      color: AppColors.blackLight,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Text(
                                    '\$',
                                    style: KTextStyle.textStyle8.copyWith(
                                      color: AppColors.greyDark,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'السعر النهائي',
                              style: KTextStyle.textStyle10.copyWith(
                                color: AppColors.blackLight,
                              ),
                            ),
                            SizedBox(
                              width: 10.h,
                            ),
                            SizedBox(
                              height: 30.h,
                              width: 80.w,
                              child: TextFormField(
                                style: KTextStyle.textStyle10.copyWith(
                                  color: AppColors.primary,
                                ),
                                controller: newPriceController,
                                onChanged: _onNewPriceChanged,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(left: 4.w, right: 4.w),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: AppColors.greyLight,
                                      size: 10,
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
