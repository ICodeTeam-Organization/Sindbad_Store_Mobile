import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/widgets/view_offer_details_bouns_body.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/widgets/view_offer_details_discount_body.dart';

class ViewOfferDetailsScreen extends StatelessWidget {
  final int offerId;
  final String offerName;
  final String offertype;

  const ViewOfferDetailsScreen({
    super.key,
    required this.offerName,
    required this.offertype,
    required this.offerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: offertype == 'نسبة'
          ? ViewOfferDetailsDiscountBody(
              offerId: offerId,
              offerName: offerName,
            )
          : ViewOfferDetailsBounsBody(
              offerId: offerId,
              offerName: offerName,
            ),
    );
  }
}
