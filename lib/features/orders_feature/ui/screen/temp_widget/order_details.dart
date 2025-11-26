import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../injection_container.dart';
import '../../../../../core/swidgets/new_widgets/custom_app_bar.dart';
import '../../../data/repos_impl/all_order_repo_impl.dart';
import '../../../domain/usecases/order_details_usecase.dart';
import '../../manager/order_details/order_details_cubit.dart';
import '../../widget/order_body.dart';
import '../../widget/order_body_details.dart';
import '../../widget/order_details_widget/order_details_body.dart';
import '../../widget/order_details_widget/show_create_bill_and_cancel_order.dart';
import '../../widget/order_details_widget/show_print_and_shipping_order.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.orderId,
    required this.orderNumber,
    required this.billNumber,
    required this.date,
    required this.itemNumber,
    required this.paymentInfo,
    required this.orderStatus,
    required this.packageId,
  });
  final int orderId;
  final int packageId;
  final String orderNumber;
  final String billNumber;
  final String date;
  final String itemNumber;
  final String paymentInfo;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => OrderDetailsCubit(
                OrderDetailsUsecase(
                  getit<AllOrderRepoImpl>(),
                ),
              ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  CustomAppBar(
                    tital: 'الطلب',
                    isSearch: false,
                  ),
                  //! Show Order
                  OrderBodyDetails(
                    idPackage: packageId,
                    idOrder: orderId,
                    numberBill: billNumber,
                    numberOrder: orderNumber,
                    date: date,
                    numberItem: itemNumber,
                    infoPayment: paymentInfo,
                    statusOrder: orderStatus,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Image.asset("assets/down.png"),
                  ),
                  //! Order Detaials
                  OrderDetailsBody(),
                  //! Show Button
                  Column(
                    children: [
                      if (orderStatuss == '2') ShowCreateBillAndCancelOrder(),
                      if ((orderStatuss == '4')) ShowPrintAndShippingOrder(),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
