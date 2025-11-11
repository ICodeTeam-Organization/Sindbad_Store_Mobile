import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/counter_quantity_tile_widget.dart';

class CounterQuantityBounsWidget extends StatelessWidget {
  final int numberToBuy;
  final int numberToGet;
  final ValueChanged<int> onNumberToBuyChanged;
  final ValueChanged<int> onNumberToGetChanged;

  const CounterQuantityBounsWidget({
    super.key,
    required this.numberToBuy,
    required this.numberToGet,
    required this.onNumberToBuyChanged,
    required this.onNumberToGetChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CounterQuantityTileWidget(
            title: 'كمية شراء المنتج المطلوبة للحصول على العرض',
            value: numberToBuy,
            onChanged: onNumberToBuyChanged),
        SizedBox(height: 5.h),
        CounterQuantityTileWidget(
            title: 'الكمية التي سيحصل عليها العميل من نفس المنتج',
            value: numberToGet,
            onChanged: onNumberToGetChanged),
      ],
    );
  }
}
