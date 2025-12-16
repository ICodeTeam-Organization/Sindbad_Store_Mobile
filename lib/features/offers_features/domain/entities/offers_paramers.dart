import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';

class UpdateOfferParams {
  final String offerTitle;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final int typeName;
  final List<OfferHeadOffer>? listProduct;
  final int offerHeadId;

  UpdateOfferParams(
    this.offerTitle,
    this.startOffer,
    this.endOffer,
    this.countProducts,
    this.typeName,
    this.listProduct,
    this.offerHeadId,
  );
}
