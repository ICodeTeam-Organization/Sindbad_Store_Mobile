import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/orders_list_view_shared.dart';

import '../../../manager/all_order/all_order_cubit.dart';
import '../../../manager/all_order/all_order_state.dart';
import '../../order_body.dart';

class UrgentNoBillInfoOrder extends StatefulWidget {
  const UrgentNoBillInfoOrder({
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
  State<UrgentNoBillInfoOrder> createState() => _UrgentNoBillInfoOrderState();
}

class _UrgentNoBillInfoOrderState extends State<UrgentNoBillInfoOrder> {
    @override
  Widget build(BuildContext context) {
    // context.read<AllOrderCubit>().fetchAllOrder(
    //       isUrgen: true,
    //       canceled: false,
    //       delevred: false,
    //       noInvoice: true,
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
          noInvoice: true,
          unpaied: false,
          paied: false,
          pageSize: 10,
    );
  }
}
