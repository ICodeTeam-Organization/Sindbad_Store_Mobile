// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../manager/all_order/all_order_cubit.dart';
// import '../../../manager/all_order/all_order_state.dart';
// import '../../order_body.dart';

// class AllInfoOrder extends StatefulWidget {
//   const AllInfoOrder({
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
//   State<AllInfoOrder> createState() => _AllInfoOrderState();
// }

// class _AllInfoOrderState extends State<AllInfoOrder> {
//   late final ScrollController _scrollController;
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     var currentPostions = _scrollController.position.pixels;
//     var maxScrollLenght = _scrollController.position.maxScrollExtent;
//     if (currentPostions >= 0.7 * maxScrollLenght) {
//       BlocProvider.of<AllOrderCubit>(context).fetchAllOrder(
//         isUrgen: false,
//         canceled: false,
//         delevred: false,
//         noInvoice: false,
//         unpaied: false,
//         paied: false,
//         pageNumber: 1,
//         pageSize: 100,
//         // srearchKeyword: ''
//       );
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     context.read<AllOrderCubit>().fetchAllOrder(
//           isUrgen: false,
//           canceled: false,
//           delevred: false,
//           noInvoice: false,
//           unpaied: false,
//           paied: false,
//           pageNumber: 1,
//           pageSize: 100,
//           // srearchKeyword: ''
//         );

//     return BlocBuilder<AllOrderCubit, AllOrderState>(
//       builder: (context, state) {
//         if (state is AllOrderSuccess) {
//           return ListView.builder(
//             physics: BouncingScrollPhysics(),
//             itemCount: state.orders.length,
//             itemBuilder: (BuildContext context, int i) {
//               return Column(
//                 children: [
//                   OrderBody(
//                     billNumber: state.orders[i].orderBill,
//                     orderNumber: state.orders[i].orderNum,
//                     date: state.orders[i].orderDates,
//                     itemNumber: state.orders[i].productMount,
//                     paymentInfo: state.orders[i].payStatus,
//                     orderStatus: state.orders[i].orderStatuse,
//                     idOrder: state.orders[i].idOrder,
//                     idPackage: state.orders[i].idPackage,
//                   ),
//                   if (i == state.orders.length - 1)
//                     SizedBox(
//                       height: 120.h,
//                     ),
//                 ],
//               );
//             },
//           );
//         } else if (state is AllOrderFailuer) {
//           return Center(child: Text(state.errMessage));
//         } else if (state is AllOrderLoading) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               itemCount: 6,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Container(
//                     color: Colors.white,
//                     height: 130.h,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                 );
//               },
//             ),
//           );
//         } else {
//           return Container(
//             color: Colors.red.shade400,
//             height: 50,
//             width: 300,
//             child: Text('لم يتم الوصول الى المعلومات'),
//           );
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/orders_list_view_shared.dart';

class AllInfoOrder extends StatelessWidget {
  const AllInfoOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return OrdersListView(
      isUrgen: false,
      canceled: false,
      delevred: false,
      noInvoice: false,
      unpaied: false,
      paied: false,
      pageSize: 10,
    );
  }
}