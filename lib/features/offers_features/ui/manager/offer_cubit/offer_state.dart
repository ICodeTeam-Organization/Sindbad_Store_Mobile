part of 'offer_cubit.dart';

@immutable
sealed class OfferState {}

final class OfferInitial extends OfferState {}

final class OfferLoadInProgress extends OfferState {}

final class OffersLoadFailuer extends OfferState {
  final String errMessage;

  OffersLoadFailuer({required this.errMessage});
}

final class OfferLoadSuccess extends OfferState {}

final class OfferAddSuccess extends OfferState {}
