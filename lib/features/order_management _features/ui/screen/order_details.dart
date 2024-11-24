// import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../function/status_helper.dart';
import '../manager/cubit/refresh_page_cubit.dart';
import '../widget/order_body.dart';
import '../widget/order_details_widget/the_order.dart';
import '../widget/order_details_widget/order_details_body.dart';
import '../widget/order_details_widget/show_create_bill_and_cancel_order.dart';
import '../widget/order_details_widget/show_print_and_shipping_order.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    bool isbillDone = context.watch<RefreshPageCubit>().isbillDone;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomAppBar(
                tital: 'الطلب',
              ),
              ////////////////////////////
              ///Show Order
              // TheOrder(
              //   orderNumber: '111111111',
              //   billNumber: '123456789',
              //   clock: '4:15',
              //   date: '2024/11/21',
              //   itemNumber: 25,
              //   paymentInfo: 'لا يوجد',
              // ),
              OrderBody(
                billNumber: '1111111',
                orderNumber: '123456789',
                clock: '4:14',
                date: '2024/11/23',
                itemNumber: 25,
                paymentInfo: 'لا يوجد',
                orderStatus: 1,
              ),
              ///////////////////
              ///icon
              Center(
                child: Icon(Icons.swipe_down),
              ),
              ////////////////////////////////////////
              ///Order Detaials
              OrderDetailsBody(),
              ///////////////////////////////////////
              ///Show Button
              if (isbillDone == false) ShowCreateBillAndCancelOrder(),
              if (isbillDone == true) ShowPrintAndShippingOrder(),
            ],
          ),
        ),
      ),
    );
  }
}
