part of 'update_offer_cubit.dart';

@immutable
sealed class UpdateOfferState {}

final class UpdateOfferInitial extends UpdateOfferState {}

class UpdateOfferLoading extends UpdateOfferState {}

class UpdateOfferSuccess extends UpdateOfferState {
  final String updateOffer;

  UpdateOfferSuccess(this.updateOffer);
}

class UpdateOfferFailure extends UpdateOfferState {
  final String errorMessage;

  UpdateOfferFailure(this.errorMessage);
}
