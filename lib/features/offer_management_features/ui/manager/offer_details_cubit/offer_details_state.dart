part of 'offer_details_cubit.dart';

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
