import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../manager/all_order/all_order_cubit.dart';
import '../../manager/all_order/all_order_state.dart';
import '../order_body.dart';

class CanceledTabViews extends StatefulWidget {
  const CanceledTabViews({
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
  State<CanceledTabViews> createState() => _CanceledTabViewsState();
}

class _CanceledTabViewsState extends State<CanceledTabViews> {
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
        canceled: true,
        delevred: false,
        noInvoice: false,
        unpaied: false,
        paied: false,
        pageNumber: 1,
        pageSize: 10,
        storeId: '85dda4e8-4685-4ae3-b1bb-ea78569fb966',
        // srearchKeyword: ''
      );
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
          canceled: true,
          delevred: false,
          noInvoice: false,
          unpaied: false,
          paied: false,
          pageNumber: 1,
          pageSize: 10,
          storeId: '85dda4e8-4685-4ae3-b1bb-ea78569fb966',
          // srearchKeyword: ''
        );

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
                clock: '12:12',
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
