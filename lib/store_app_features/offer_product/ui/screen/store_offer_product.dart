import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/store_offer_product_widget.dart';

class StoreOfferProduct extends StatelessWidget {
  const StoreOfferProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          KCustomAppBarWidget(nameAppbar: "المنتجات التي بها عروض"),
          StoreOfferProductWidget(
            productNum: '',
            productName: '',
          ),
        ],
      ),
    );
  }
}
