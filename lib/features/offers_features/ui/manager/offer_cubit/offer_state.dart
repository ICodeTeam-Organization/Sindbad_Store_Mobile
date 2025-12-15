part of 'offer_cubit.dart';

@immutable
sealed class OfferState {}

final class OfferInitial extends OfferState {}

final class OfferLoadInProgress extends OfferState {}

final class OfferLoadFailuer extends OfferState {
  final String errMessage;

  OfferLoadFailuer({required this.errMessage});
}

final class OfferLoadSuccess extends OfferState {}

final class OfferAddSuccess extends OfferState {}
