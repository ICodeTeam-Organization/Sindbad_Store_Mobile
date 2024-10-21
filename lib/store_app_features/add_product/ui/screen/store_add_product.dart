import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';

class StoreAddProduct extends StatelessWidget {
  const StoreAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          KCustomAppBarWidget(
            nameAppbar: "اضافة منتج",
            count: 0,
            isHome: false,
          )
        ],
      ),
    );
  }
}
