import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/offers_repository_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/add_offer_paramers.dart';

class AddOfferUseCase extends UseCaseWithParam<bool, AddOfferParams> {
  final OffersRepositoryImpl offersRepository;

  AddOfferUseCase(this.offersRepository);

  @override
  Future<Either<Failure, bool>> execute(AddOfferParams params) {
    return offersRepository.addOffer(
      name: params.name,
      description: params.description,
      startDate: params.startDate,
      endDate: params.endDate,
      isActive: params.isActive,
      numberOfOrders: params.numberOfOrders,
      offerHeadType: params.offerHeadType,
      offerHeadOffers: params.offerHeadOffers,
    );
  }
}
