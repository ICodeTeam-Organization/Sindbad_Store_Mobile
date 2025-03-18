import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/orders_list_view_shared.dart';

class UrgentAllInfoOrder extends StatefulWidget {
  const UrgentAllInfoOrder({
    super.key,
    this.orderNumber,
    this.billNumber,
    this.clock,
    this.date,
    this.itemNumber,
    this.paymentInfo,
  });
  final String? orderNumber;
  final String? billNumber;
  final String? clock;
  final String? date;
  final int? itemNumber;
  final String? paymentInfo;

  @override
  State<UrgentAllInfoOrder> createState() => _UrgentAllInfoOrderState();
}

class _UrgentAllInfoOrderState extends State<UrgentAllInfoOrder> {
  @override
  Widget build(BuildContext context) {
    // context.read<AllOrderCubit>().fetchAllOrder(
    //       isUrgen: true,
    //       canceled: false,
    //       delevred: false,
    //       noInvoice: false,
    //       unpaied: false,
    //       paied: false,
    //       pageNumber: 1,
    //       pageSize: 100,
    //       // srearchKeyword: ''
    //     );
    return OrdersListView(
      isUrgen: true,
      canceled: false,
      delevred: false,
      noInvoice: false,
      unpaied: false,
      paied: false,
      pageSize: 10,
    );
  }
}
