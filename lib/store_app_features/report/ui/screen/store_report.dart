import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';

class StoreReport extends StatelessWidget {
  const StoreReport({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          KCustomAppBarWidget(
            nameAppbar: "التقارير",
            count: 0,
            isHome: false,
          ),
        ],
      ),
    );
  }
}
