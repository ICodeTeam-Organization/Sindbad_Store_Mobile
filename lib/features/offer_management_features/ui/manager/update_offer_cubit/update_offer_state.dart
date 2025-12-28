part of 'update_offer_cubit.dart';

@immutable
sealed class UpdateOfferState {}

final class UpdateOfferInitial extends UpdateOfferState {}

final class UpdateOfferLoading extends UpdateOfferState {}

final class UpdateOfferSuccess extends UpdateOfferState {
  final String updateOffer;

  UpdateOfferSuccess(this.updateOffer);
}

final class UpdateOfferFailure extends UpdateOfferState {
  final String errorMessage;

  UpdateOfferFailure(this.errorMessage);
}
