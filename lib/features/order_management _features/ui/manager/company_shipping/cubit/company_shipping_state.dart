part of 'company_shipping_cubit.dart';

sealed class CompanyShippingState {}

final class CompanyShippingInitial extends CompanyShippingState {}

final class CompanyShippingLoading extends CompanyShippingState {}

final class CompanyShippingFailure extends CompanyShippingState {
  final String errMessage;

  CompanyShippingFailure({required this.errMessage});
}

final class CompanyShippingSuccess extends CompanyShippingState {
  final List<CompanyShippingEntity> companyShippingEntity;

  CompanyShippingSuccess({required this.companyShippingEntity});
}
