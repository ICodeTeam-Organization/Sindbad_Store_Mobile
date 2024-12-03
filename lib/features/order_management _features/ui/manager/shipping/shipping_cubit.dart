import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/order_shipping_entity.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_shipping_usecase.dart';

part 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  ShippingCubit(this.orderShippingUsecase) : super(ShippingInitial());
  final OrderShippingUsecase orderShippingUsecase;
  Future<void> fetchOrderShipping({
    required int orderId,
    required String invoiceDate,
    required int shippingNumber,
    required String shippingCompany,
    required File shippingImages,
    required int numberParcels,
  }) async {
    emit(ShippingLoading());
    try {
      var params = OrderShippingParam(
          orderId: orderId,
          invoiceDate: invoiceDate,
          shippingNumber: shippingNumber,
          shippingCompany: shippingCompany,
          shippingImages: shippingImages,
          numberParcels: numberParcels);
      final result = await orderShippingUsecase.execute(params);
      result
          .fold((failure) => emit(ShippingFailure(errMessage: failure.message)),
              (serverMessage) {
        if (serverMessage.isSuccess == true) {
          emit(ShippingSuccess(serverMessage: serverMessage));
        } else {
          emit(ShippingFailure(errMessage: serverMessage.serverMessage));
        }
      });
    } catch (e) {}
  }
}
