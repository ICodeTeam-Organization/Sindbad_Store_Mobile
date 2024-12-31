import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_shipping_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/repos/all_order_repo.dart';
import '../../../../core/use_cases/param_use_case.dart';

class OrderShippingUsecase
    extends UseCaseWithParam<OrderShippingEntity, OrderShippingParam> {
  final AllOrderRepo allOrderRepo;
  OrderShippingUsecase({required this.allOrderRepo});

  @override
  Future<Either<Failure, OrderShippingEntity>> execute(
      OrderShippingParam params) async {
    return await allOrderRepo.fetchOrderShipping(
        packageId: params.packageId,
        invoiceDate: params.invoiceDate,
        shippingNumber: params.shippingNumber,
        shippingCompany: params.shippingCompany,
        shippingImages: params.shippingImages,
        numberParcels: params.numberParcels);
  }
}

class OrderShippingParam {
  final int packageId;
  final DateTime invoiceDate;
  final int shippingNumber;
  final String shippingCompany;
  final File shippingImages;
  final int numberParcels;

  OrderShippingParam(
      {required this.packageId,
      required this.invoiceDate,
      required this.shippingNumber,
      required this.shippingCompany,
      required this.shippingImages,
      required this.numberParcels});
}
