import 'package:flutter/material.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/store_order_processing_container_body.dart';

class StoreOrderProcessingContainer extends StatelessWidget {
  const StoreOrderProcessingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const StoreOrderProcessingContainerBody(
      numberOrder: '2622',
      date: '2024/10/2',
      numberItem: '5',
    );
  }
}
