import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/store_list_view_offer.dart';

class StoreOffer extends StatelessWidget {
  const StoreOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          KCustomAppBarWidget(nameAppbar: "العروض"),
          SingleChildScrollView(
            child: StoreListViewOffer(),
          ),
        ],
      ),
    );
  }
}
