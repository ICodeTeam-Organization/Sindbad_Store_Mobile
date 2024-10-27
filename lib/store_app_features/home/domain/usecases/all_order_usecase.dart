// import 'package:dartz/dartz.dart';
// import 'package:sindbad_management_app/core/errors/failure.dart';
// import 'package:sindbad_management_app/core/use_cases/param_use_case.dart';
// import 'package:sindbad_management_app/store_app_features/home/domain/entities/all_order.dart';
// import 'package:sindbad_management_app/store_app_features/home/domain/repos/all_order_repo.dart';

// class AllOrderUsecase
//     extends UseCaseWithParam<List<AllOrderEntity>, AllOraderParam> {
//   final AllOrderRepo allOrderRepo;

//   AllOrderUsecase(this.allOrderRepo);

//   @override
//   Future<Either<Failure, List<AllOrderEntity>>> execute(
//       AllOraderParam params)async {
//         return await allOrderRepo.fetchAllOrder(pageNumber: params.pageNumber,
//         pageSize: params.pageSize,
//         storeId: params.storeId,
//         srearchKeyword: params.srearchKeyword)
//       }
// }

// class AllOraderParam {
//   final String storeId;
//   final int srearchKeyword;
//   final int pageNumber;
//   final int pageSize;
//   AllOraderParam(
//       this.pageNumber, this.pageSize, this.storeId, this.srearchKeyword);
// }
