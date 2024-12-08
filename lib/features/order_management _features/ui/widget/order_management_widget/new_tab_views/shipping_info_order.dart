// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../../../core/utils/route.dart';
// import '../../../function/status_helper.dart';
// import '../../order_body.dart';

// class ShippingInfoOrder extends StatelessWidget {
//   const ShippingInfoOrder({
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
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 4,
//       itemBuilder: (BuildContext context, int index) {
//         final status = myStatuses[index];
//         return InkWell(
//           onTap: () {
//             context.push(
//               AppRouter.storeRouters.details,
//               // extra: idOrder,
//             );
//           },
//           child: OrderBody(
//             orderNumber: '111111111',
//             billNumber: '123456789',
//             clock: '4:15',
//             date: '2024/11/23',
//             itemNumber: '25',
//             paymentInfo: 'لا يوجد',
//             orderStatus: '4',
//           ),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../core/utils/route.dart';
import '../../../function/status_helper.dart';
import '../../../manager/all_order/all_order_cubit.dart';
import '../../../manager/all_order/all_order_state.dart';
import '../../order_body.dart';

class ShippingInfoOrder extends StatefulWidget {
  const ShippingInfoOrder({
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
  State<ShippingInfoOrder> createState() => _ShippingInfoOrderState();
}

class _ShippingInfoOrderState extends State<ShippingInfoOrder> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    var currentPostions = _scrollController.position.pixels;
    var maxScrollLenght = _scrollController.position.maxScrollExtent;
    if (currentPostions >= 0.7 * maxScrollLenght) {
      BlocProvider.of<AllOrderCubit>(context).fetchAllOrder(
          isUrgen: false,
          canceled: false,
          delevred: false,
          noInvoice: false,
          unpaied: false,
          paied: true,
          pageNumber: 1,
          pageSize: 10,
          srearchKeyword: '');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AllOrderCubit>().fetchAllOrder(
        isUrgen: false,
        canceled: false,
        delevred: false,
        noInvoice: false,
        unpaied: false,
        paied: true,
        pageNumber: 1,
        pageSize: 10,
        srearchKeyword: '');

    return BlocBuilder<AllOrderCubit, AllOrderState>(
      builder: (context, state) {
        if (state is AllOrderSuccess) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.orders.length,
            itemBuilder: (BuildContext context, int i) {
              // final status = myStatuses[i];
              return OrderBody(
                idOrder: state.orders[i].idOrder,
                billNumber: state.orders[i].orderBill,
                orderNumber: state.orders[i].orderNum,
                clock: '5:05',
                date: state.orders[i].orderDates,
                itemNumber: state.orders[i].productMount,
                paymentInfo: state.orders[i].payStatus,
                orderStatus: state.orders[i].orderStatuse,
              );
            },
          );
        } else if (state is AllOrderFailuer) {
          return Text(state.errMessage);
        } else if (state is AllOrderLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 6,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    color: Colors.white,
                    height: 130.h,
                    width: MediaQuery.of(context).size.width,
                  ),
                );
              },
            ),
          );
        } else {
          return Container(
            color: Colors.red.shade400,
            height: 50,
            width: 300,
            child: Text('لم يتم الوصول الى المعلومات'),
          );
        }
      },
    );
  }
}
