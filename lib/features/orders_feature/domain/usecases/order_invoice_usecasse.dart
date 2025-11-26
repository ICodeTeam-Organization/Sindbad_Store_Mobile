import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/order_invoice_entity.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/use_cases/param_use_case.dart';
import '../repos/all_order_repo.dart';

class OrderInvoiceUsecase
    extends UseCaseWithParam<OrderInvoiceEntity, OrderInvoiceParam> {
  final AllOrderRepo allOrderRepo;

  OrderInvoiceUsecase({required this.allOrderRepo});

  @override
  Future<Either<Failure, OrderInvoiceEntity>> execute(
      OrderInvoiceParam params) async {
    return await allOrderRepo.fetchOrderInvoice(
      packageId: params.packageId,
      invoiceNumber: params.invoiceNumbers,
      invoiceAmount: params.invoiceAmounts,
      invoiceImage: params.invoiceImages,
      invoiceDate: params.invoiceDate,
      invoiceType: params.invoiceType,
    );
  }
}

class OrderInvoiceParam {
  final int? packageId;
  final String invoiceNumbers;
  final num? invoiceAmounts;
  final File invoiceImages;
  final DateTime invoiceDate;
  final int invoiceType;

  OrderInvoiceParam({
    required this.packageId,
    required this.invoiceNumbers,
    required this.invoiceAmounts,
    required this.invoiceImages,
    required this.invoiceDate,
    required this.invoiceType,
  });
}
