import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/shared_widgets/store_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/stop_product/ui/widget/store_stop_product_widget.dart';

class StoreStoppedProduct extends StatelessWidget {
  const StoreStoppedProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          StoreAppBarWidget(appBarName: "المنتجات الموقوفة"),
          StoreStopProductWidget(
            productNum: '',
            productName: '',
          )
        ],
      ),
    );
  }
}
