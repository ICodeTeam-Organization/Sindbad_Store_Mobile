import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/orders_features/domain/entities/company_shipping_entity.dart';
import 'package:sindbad_management_app/features/orders_features/domain/usecases/company_shipping_usecase.dart';
part 'company_shipping_state.dart';

class CompanyShippingCubit extends Cubit<CompanyShippingState> {
  CompanyShippingCubit(this.companyShippingUsecase)
      : super(CompanyShippingInitial());
  final CompanyShippingUsecase companyShippingUsecase;

  Future<void> getCompanyShipping({
    required int pageNumber,
    required int pageSize,
  }) async {
    emit(CompanyShippingLoading());
    var result = await companyShippingUsecase.execute(
        CompanyShippingParam(pageNumber: pageNumber, pageSize: pageSize));
    result.fold(
        (failure) => emit(CompanyShippingFailure(errMessage: failure.message)),
        (companyShipping) => emit(
            CompanyShippingSuccess(companyShippingEntity: companyShipping)));
  }
}
