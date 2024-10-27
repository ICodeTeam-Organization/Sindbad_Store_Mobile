import 'package:flutter/material.dart';
import 'package:sindbad_management_app/store_app_features/home/ui/widget/order_details_button.dart';

class StoreHomePageListViewNew extends StatelessWidget {
  const StoreHomePageListViewNew({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, i) {
          return const OrderDetailsButton(
            bondNum: '654654',
            date: '2024/10/2',
            itemNum: '1',
          );
        });
  }
}
