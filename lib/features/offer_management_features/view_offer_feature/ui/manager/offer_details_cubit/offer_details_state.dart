import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/entities/offer_details_entity.dart';

@immutable
sealed class OfferDetailsState {}

final class OfferDetailsInitial extends OfferDetailsState {}

final class OfferDetailsLoading extends OfferDetailsState {}

final class OfferDetailsFailuer extends OfferDetailsState {
  final String errMessage;

  OfferDetailsFailuer({required this.errMessage});
}

final class OfferDetailsSuccess extends OfferDetailsState {
  final List<OfferDetailsEntity> offerDetails;

  OfferDetailsSuccess({required this.offerDetails});
}
