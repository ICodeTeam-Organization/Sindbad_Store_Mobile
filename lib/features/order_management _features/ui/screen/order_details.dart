// import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/refresh/refresh_page_state.dart';
import '../../../../core/setup_service_locator.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../data/repos_impl/all_order_repo_impl.dart';
import '../../domain/usecases/order_details_usecase.dart';
import '../manager/order_details/order_details_cubit.dart';
import '../manager/refresh/refresh_page_cubit.dart';
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
      required this.orderStatus,
      required this.packageId});
  final int orderId;
  final int packageId;
  final String orderNumber;
  final String billNumber;
  final String clock;
  final String date;
  final String itemNumber;
  final String paymentInfo;
  final String orderStatus;

  @override
  Widget build(BuildContext context) {
    // bool isbillDone = RefreshPageCubit.get(context).isbillDone;
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
                  //Show Order
                  OrderBodyD(
                    idPackage: packageId,
                    idOrder: orderId,
                    numberBill: billNumber,
                    numberOrder: orderNumber,
                    date: date,
                    numberItem: itemNumber,
                    infoPayment: paymentInfo,
                    statusOrder: orderStatus,
                  ),
                  //icon
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Image.asset("assets/down.png"),
                  ),
                  //Order Detaials
                  OrderDetailsBody(),
                  //Show Button
                  if (paymentInfos != 'لا شي')
                    BlocBuilder<RefreshPageCubit, RefreshPageState>(
                      builder: (context, state) {
                        // Default orders status map
                        Map<int, bool> ordersStatus = {};

                        if (state is RefreshUpdated) {
                          ordersStatus = state.ordersStatus;
                        }
                        // Assuming `orderId` is available for each order in your list
                        final isBillDone = ordersStatus[orderId] ?? false;
                        return Column(
                          children: [
                            if ((!isBillDone && billNumbers == 'لايوجد') ||
                                (billNumbers == 'لايوجد') ||
                                (!isBillDone &&
                                    int.tryParse(billNumbers!) == null))
                              ShowCreateBillAndCancelOrder(
                                onCreateInvoice: () {
                                  context
                                      .read<RefreshPageCubit>()
                                      .toggleBillStatus(orderId);
                                },
                              ),
                            if ((isBillDone && billNumbers != 'لايوجد') ||
                                (billNumbers != 'لايوجد'))
                              ShowPrintAndShippingOrder(),
                          ],
                        );
                      },
                    )
                ],
              ),
            ),
          )),
    );
  }
}
