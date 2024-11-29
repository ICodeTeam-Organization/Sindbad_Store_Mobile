part of 'offer_cubit.dart';

@immutable
sealed class OfferState {}

final class OfferInitial extends OfferState {}

final class OfferLoading extends OfferState {}

final class OfferFailuer extends OfferState {
  final String errMessage;

  OfferFailuer({required this.errMessage});
}

final class OfferSuccess extends OfferState {
  final List<OfferEntity> offer;

  OfferSuccess({required this.offer});
}
