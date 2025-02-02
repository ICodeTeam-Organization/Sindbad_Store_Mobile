import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/counter_quantity_bouns_widget.dart';

class CardProductBounsWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final int numberToBuy;
  final int numberToGet;
  final void Function()? onTapQuit;
  final ValueNotifier<int> numberToBuyNotifier;
  final ValueNotifier<int> numberToGetNotifier;

  const CardProductBounsWidget({
    super.key,
    required this.productName,
    required this.productImage,
    required this.numberToBuy,
    required this.numberToGet,
    this.onTapQuit,
    required this.numberToBuyNotifier,
    required this.numberToGetNotifier,
  });

  @override
  State<CardProductBounsWidget> createState() => _CardProductBounsWidgetState();
}

class _CardProductBounsWidgetState extends State<CardProductBounsWidget> {
  late int numberToBuyController;
  late int numberToGetController;

  @override
  void initState() {
    super.initState();
    // Initialize TextEditingControllers with the current values
    numberToBuyController = widget.numberToBuy;
    numberToGetController = widget.numberToGet;
    // Add listeners to update controllers and trigger UI rebuild
    widget.numberToBuyNotifier.addListener(() {
      setState(() {
        numberToBuyController = widget.numberToBuyNotifier.value;
      });
    });
    widget.numberToGetNotifier.addListener(() {
      setState(() {
        numberToGetController = widget.numberToGetNotifier.value;
      });
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
                alignment: Alignment.bottomCenter,
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: CounterQuantityBounsWidget(
                      numberToBuy: widget.numberToBuy,
                      numberToGet: widget.numberToGet,
                      onNumberToBuyChanged: (newBuysCount) {
                        widget.numberToBuyNotifier.value = newBuysCount;
                      },
                      onNumberToGetChanged: (newFreesCount) {
                        widget.numberToGetNotifier.value = newFreesCount;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
