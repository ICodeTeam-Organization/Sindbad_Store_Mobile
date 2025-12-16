import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/offers_repository_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/change_statues_paramers.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/post_response_entity.dart';

class ChangeStatusOfferUseCase
    extends UseCaseWithParam<PostResponseEntity, ChangeStatusOfferParams> {
  final OffersRepositoryImpl offerRepo;

  ChangeStatusOfferUseCase(this.offerRepo);

  @override
  Future<Either<Failure, PostResponseEntity>> execute(
      ChangeStatusOfferParams params) {
    return offerRepo.changeStatusOffer(params.offerHeadId);
  }
}
