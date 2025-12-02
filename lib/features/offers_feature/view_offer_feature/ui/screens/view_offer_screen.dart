import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/offers_feature/view_offer_feature/ui/widgets/view_offer_body.dart';

class ViewOfferScreen extends StatelessWidget {
  const ViewOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewOfferBody(),
    );
  }
}
