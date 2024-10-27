import 'package:flutter/material.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/button_widget.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/product_overview_widget.dart';

class StoreOfferProductBody extends StatelessWidget {
  const StoreOfferProductBody({super.key, this.productNum, this.productName});
  final String? productNum;
  final String? productName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProductOverviewWidget(
          productNum: '',
          productName: '',
        ),
        ButtonWidget(
          onPressed: () {},
        )
      ],
    );
  }
}
