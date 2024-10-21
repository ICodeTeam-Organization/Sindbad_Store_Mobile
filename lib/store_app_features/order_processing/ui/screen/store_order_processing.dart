import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/function/Store_button_function.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/store_order_processing_container.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/store_order_processing_list_view_widget.dart';

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
                StoreOrderProcessingContainer(
                  numberOrder: '2622',
                  date: '2024/10/2',
                  numberItem: '5',
                ),
                StoreOrderProcessingListViewWidget(
                  idOrder: '2622',
                  imageCode: "assets/code.png",
                  productName:
                      " براد شاي مع امكانية التفاف النص براد شاي مع امكانية التفاف النص ",
                  quantity: '1',
                  price: '150',
                  totalPrice: '150',
                  totalQuantity: '1',
                  imageProduct: 'assets/2.png',
                ),
              ],
            ),
          ),
          StoreButtonListViewFunction()
        ],
      ),
    );
  }
}
