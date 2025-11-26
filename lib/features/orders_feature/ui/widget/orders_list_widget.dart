// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sindbad_management_app/features/orders_features/ui/manager/all_order/all_order_cubit.dart';
// import 'package:sindbad_management_app/features/orders_features/ui/manager/all_order/all_order_state.dart';
// import 'package:sindbad_management_app/features/orders_features/ui/widget/order_body.dart';

// class OrdersListView extends StatefulWidget {
//   final List<int> statuses;
//   final bool isUrgent;
//   final int pageSize;

//   const OrdersListView({
//     super.key,
//     required this.statuses,
//     required this.isUrgent,
//     required this.pageSize,
//   });

//   @override
//   State<OrdersListView> createState() => _OrdersListViewState();
// }

// class _OrdersListViewState extends State<OrdersListView> {
//   final ScrollController _scrollController = ScrollController();
//   bool isFetching = false;
//   int pageNumber = 1;
//   List<dynamic> orders = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchOrders();
//     _scrollController.addListener(_onScroll);
//   }

//   Future<void> _fetchOrders({bool isRefresh = false}) async {
//     if (isRefresh) {
//       setState(() {
//         pageNumber = 1;
//         orders.clear();
//       });
//     }
//     if (isFetching) return;
//     setState(() => isFetching = true);

//     await context.read<AllOrderCubit>().fetchAllOrder(
//           statuses: widget.statuses,
//           isUrgent: widget.isUrgent,
//           pageNumber: pageNumber,
//           pageSize: widget.pageSize,
//         );

//     setState(() => isFetching = false);
//   }

//   void _onScroll() {
//     if (_scrollController.position.pixels >=
//         0.7 * _scrollController.position.maxScrollExtent) {
//       pageNumber++;
//       _fetchOrders();
//     }
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AllOrderCubit, AllOrderState>(
//       listener: (context, state) {
//         if (state is AllOrderSuccess) {
//           setState(() {
//             if (pageNumber == 1) {
//               orders = state.orders;
//             } else {
//               orders.addAll(state.orders);
//             }
//           });
//         } else if (state is AllOrderFailuer) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(state.errMessage),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       },
//       builder: (context, state) {
//         if (state is AllOrderLoading && pageNumber == 1) {
//           return Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               itemCount: 6,
//               itemBuilder: (context, index) => ListTile(
//                 title: Container(
//                   color: Colors.white,
//                   height: 130.h,
//                   width: MediaQuery.of(context).size.width,
//                 ),
//               ),
//             ),
//           );
//         }

//         if (orders.isEmpty) {
//           return const Center(
//             child: Text(
//               "لا توجد طلبات",
//               style: TextStyle(fontSize: 18, color: Colors.grey),
//             ),
//           );
//         }

//         return RefreshIndicator(
//           onRefresh: () => _fetchOrders(isRefresh: true),
//           child: ListView.builder(
//             controller: _scrollController,
//             itemCount: orders.length + (isFetching ? 1 : 0),
//             itemBuilder: (context, index) {
//               if (index < orders.length) {
//                 return Column(
//                   children: [
//                     OrderBody(
//                       billNumber: orders[index].orderBill,
//                       orderNumber: orders[index].orderNum,
//                       date: orders[index].orderDates,
//                       itemNumber: orders[index].productMount,
//                       paymentInfo: orders[index].payStatus,
//                       orderStatus: orders[index].orderStatuse,
//                       idOrder: orders[index].idOrder,
//                       idPackage: orders[index].idPackage,
//                     ),
//                     if (index == orders.length - 1) SizedBox(height: 120.h),
//                   ],
//                 );
//               } else {
//                 return const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(child: CircularProgressIndicator()),
//                 );
//               }
//             },
//           ),
//         );
//       },
//     );
//   }
// }
