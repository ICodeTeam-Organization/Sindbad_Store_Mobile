import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_search_widget.dart';

class StoreSearchProduct extends StatelessWidget {
  const StoreSearchProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const KCustomAppBarWidget(
            nameAppbar: "بحث عن صنف",
            count: 0,
            isHome: false,
          ),
          KCustomSearchWidget(
            hintText: 'بحث برقم الطلب',
          )
        ],
      ),
    );
  }
}
