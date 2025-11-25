// import 'package:flutter/material.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/orders_list_view_shared.dart';

// class NoPaidInfoOrder extends StatefulWidget {
//   const NoPaidInfoOrder({
//     super.key,
//     this.orderNumber,
//     this.billNumber,
//     this.clock,
//     this.date,
//     this.itemNumber,
//     this.paymentInfo,
//   });
//   final String? orderNumber;
//   final String? billNumber;
//   final String? clock;
//   final String? date;
//   final int? itemNumber;
//   final String? paymentInfo;

//   @override
//   State<NoPaidInfoOrder> createState() => _NoPaidInfoOrderState();
// }

// class _NoPaidInfoOrderState extends State<NoPaidInfoOrder> {
//   @override
//   Widget build(BuildContext context) {
//     // context.read<AllOrderCubit>().fetchAllOrder(
//     //       isUrgen: false,
//     //       canceled: false,
//     //       delevred: false,
//     //       noInvoice: false,
//     //       unpaied: true,
//     //       paied: false,
//     //       pageNumber: 1,
//     //       pageSize: 100,
//     //       // srearchKeyword: ''
//     //     );

//     return OrdersListView(
//       statuses: [3],
//       isUrgent: false,
//       pageSize: 10,
//     );
//   }
// }
