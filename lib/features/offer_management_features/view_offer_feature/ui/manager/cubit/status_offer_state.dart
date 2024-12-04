part of 'status_offer_cubit.dart';

@immutable
abstract class StatusOfferState {}

class StatusOfferInitial extends StatusOfferState {}

class StatusOfferLoading extends StatusOfferState {}

class StatusOfferSuccess extends StatusOfferState {
  final int offerId;
  final bool newStatus;

  StatusOfferSuccess({required this.offerId, required this.newStatus});
}

class StatusOfferFailure extends StatusOfferState {
  final String errorMessage;

  StatusOfferFailure({required this.errorMessage});
}
