import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/view_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_details_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/view_offer_product_details_discount_body.dart';

class ViewOfferProductDetailsDiscountScreen extends StatelessWidget {
  final String offerName;
  final int offerId;

  const ViewOfferProductDetailsDiscountScreen({
    super.key,
    required this.offerName,
    required this.offerId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewOfferProductDetailsDiscountBody(
        offerName: offerName,
        offerId: offerId,
      ),
    );
  }
}
