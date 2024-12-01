// import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';
import '../../../../core/setup_service_locator.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../data/repos_impl/all_order_repo_impl.dart';
import '../../domain/usecases/order_details_usecase.dart';
import '../manager/order_details/order_details_cubit.dart';
import '../manager/refresh/refresh_page_cubit.dart';
import '../manager/invoice/order_invoice_cubit.dart';
import '../widget/order_body.dart';
import '../widget/order_details_d.dart';
import '../widget/order_details_widget/order_details_body.dart';
import '../widget/order_details_widget/show_create_bill_and_cancel_order.dart';
import '../widget/order_details_widget/show_print_and_shipping_order.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails(
      {super.key,
      required this.orderId,
      required this.orderNumber,
      required this.billNumber,
      required this.clock,
      required this.date,
      required this.itemNumber,
      required this.paymentInfo,
      required this.orderStatus});
  final int orderId;
  final String orderNumber;
  final String billNumber;
  final String clock;
  final String date;
  final String itemNumber;
  final String paymentInfo;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    bool isbillDone = context.watch<RefreshPageCubit>().isbillDone;
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
                ),
                ////////////////////////////
                ///Show Order
                OrderBodyD(
                  idOrder: orderId,
                  numberBill: billNumber,
                  numberOrder: orderNumber,
                  clock: '4:14',
                  date: date,
                  numberItem: itemNumber,
                  infoPayment: paymentInfo,
                  statusOrder: orderStatus,
                ),
                ///////////////////
                ///icon
                Center(
                  child: Icon(Icons.arrow_downward),
                ),
                ////////////////////////////////////////
                ///Order Detaials
                OrderDetailsBody(
                  idOrder: orderId,
                  numberBill: billNumber,
                  numberOrder: orderNumber,
                  clock: '4:14',
                  date: date,
                  numberItem: itemNumber,
                  infoPayment: paymentInfo,
                  statusOrder: orderStatus,
                ),
                ///////////////////////////////////////
                ///Show Button
                if (isbillDone == false) ShowCreateBillAndCancelOrder(),
                if (isbillDone == true) ShowPrintAndShippingOrder(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
