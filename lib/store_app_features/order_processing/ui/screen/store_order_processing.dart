import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/function/store_button_function.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/store_order_processing_container.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/store_order_processing_list_view.dart';

class StoreOrderProcessing extends StatelessWidget {
  const StoreOrderProcessing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          //AppBar
          KCustomAppBarWidget(
            nameAppbar: "تجهيز الطلب",
            count: 0,
            isHome: false,
          ),
          //Container that show detalis
          SingleChildScrollView(
            child: Column(
              children: [
                StoreOrderProcessingContainer(),
                StoreOrderProcessingListView(),
              ],
            ),
          ),
          StoreButtonList()
        ],
      ),
    );
  }
}
