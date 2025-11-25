// import 'package:flutter/material.dart';
// import 'package:sindbad_management_app/features/orders_features/ui/screen/temp_widget/orders_list_view_shared.dart';

// class CanceledTabViews extends StatefulWidget {
//   const CanceledTabViews({
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
//   State<CanceledTabViews> createState() => _CanceledTabViewsState();
// }

// class _CanceledTabViewsState extends State<CanceledTabViews> {
//   @override
//   Widget build(BuildContext context) {
//     // context.read<AllOrderCubit>().fetchAllOrder(
//     //       isUrgen: false,
//     //       canceled: true,
//     //       delevred: false,
//     //       noInvoice: false,
//     //       unpaied: false,
//     //       paied: false,
//     //       pageNumber: 1,
//     //       pageSize: 100,
//     //       // srearchKeyword: ''
//     //     );

//     return OrdersListView(
//       statuses: [8],
//       isUrgent: false,
//       pageSize: 10,
//     );
//   }
// }
