import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/orders_feature/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_shipping_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/repos/all_order_repo.dart';
import '../../../../core/use_cases/param_use_case.dart';

class OrderShippingUsecase
    extends UseCaseWithParam<OrderShippingEntity, OrderShippingParam> {
  final AllOrderRepoImpl allOrderRepo;

  OrderShippingUsecase(this.allOrderRepo);

  @override
  Future<Either<Failure, OrderShippingEntity>> execute(
      OrderShippingParam params) async {
    return await allOrderRepo.fetchOrderShipping(
        packageId: params.packageId,
        invoiceDate: params.invoiceDate,
        shippingNumber: params.shippingNumber,
        shippingCompany: params.shippingCompany,
        shippingImages: params.shippingImages,
        numberParcels: params.numberParcels,
        shippingCompniesId: params.shippingCompniesId,
        phoneNumber: params.phoneNumber);
  }
}

class OrderShippingParam {
  final int packageId;
  final DateTime invoiceDate;
  final int shippingNumber;
  final String shippingCompany;
  final File shippingImages;
  final int numberParcels;
  final int shippingCompniesId;
  final String phoneNumber;

  OrderShippingParam({
    required this.packageId,
    required this.invoiceDate,
    required this.shippingNumber,
    required this.shippingCompany,
    required this.shippingImages,
    required this.numberParcels,
    required this.phoneNumber,
    required this.shippingCompniesId,
  });
}
