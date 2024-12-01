import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/counter_quantity_widget.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/default_value_bouns_widget.dart';

class CardProductBounsWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final int buysCount;
  final int freesCount;
  final void Function()? onTapQuit;
  final ValueNotifier<int> buysCountNotifier;
  final ValueNotifier<int> freesCountNotifier;

  const CardProductBounsWidget({
    super.key,
    required this.productName,
    required this.productImage,
    required this.buysCount,
    required this.freesCount,
    this.onTapQuit,
    required this.buysCountNotifier,
    required this.freesCountNotifier,
  });

  @override
  State<CardProductBounsWidget> createState() => _CardProductBounsWidgetState();
}

class _CardProductBounsWidgetState extends State<CardProductBounsWidget> {
  late int buysCountController;
  late int freesCountController;

  @override
  void initState() {
    super.initState();

    // Initialize TextEditingControllers with the current values
    buysCountController = widget.buysCount;
    freesCountController = widget.freesCount;

    // Add listeners to update controllers and trigger UI rebuild
    widget.buysCountNotifier.addListener(() {
      setState(() {
        buysCountController = widget.buysCountNotifier.value;
      });
    });

    widget.freesCountNotifier.addListener(() {
      setState(() {
        freesCountController = widget.freesCountNotifier.value;
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
                        Row(
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
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DefaultValueBounsWidget(
                      buysCount: widget.buysCount,
                      freesCount: widget.freesCount,
                      onBuysCountChanged: (newBuysCount) {
                        widget.buysCountNotifier.value = newBuysCount;
                      },
                      onFreesCountChanged: (newFreesCount) {
                        widget.freesCountNotifier.value = newFreesCount;
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
