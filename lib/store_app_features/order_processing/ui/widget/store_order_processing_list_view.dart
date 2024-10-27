import 'package:flutter/material.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/store_order_processing_list_view_body.dart';

class StoreOrderProcessingListView extends StatelessWidget {
  const StoreOrderProcessingListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const StoreOrderProcessingListViewBody(
      orderNum: '2622',
      imageCode: "assets/code.png",
      productName:
          " براد شاي مع امكانية التفاف النص براد شاي مع امكانية التفاف النص ",
      quantity: '1',
      price: '150',
      totalPrice: '150',
      totalQuantity: '1',
      imageProduct: 'assets/2.png',
    );
  }
}
