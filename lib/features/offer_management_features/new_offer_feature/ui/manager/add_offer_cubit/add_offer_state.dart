part of 'add_offer_cubit.dart';

@immutable
sealed class AddOfferState {}

final class AddOfferInitial extends AddOfferState {}

class AddOfferLoading extends AddOfferState {}

class AddOfferSuccess extends AddOfferState {
  final String addOffer;

  AddOfferSuccess(this.addOffer);
}

class AddOfferFailure extends AddOfferState {
  final String errorMessage;

  AddOfferFailure(this.errorMessage);
}
