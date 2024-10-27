import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/products/ui/widget/store_product_list_view_widget.dart';

class StoreProducts extends StatelessWidget {
  const StoreProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.scaffColor,
      body: Column(
        children: [
          KCustomAppBarWidget(
            nameAppbar: 'قائمة الاصناف',
            count: 0,
            isHome: false,
          ),
          StoreProductListViewWidget(),
        ],
      ),
    );
  }
}
