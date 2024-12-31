import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import '../widget/order_management_widget/bottom_info_order.dart';
import '../widget/order_management_widget/top_info_order.dart';
import 'order_body.dart';

// int? idOrderD;
// String? orderNumberD;
// String? billNumberD;
// String? clockD;
// String? dateD;
// String? itemNumberD;
// String? paymentInfoD;
// String? orderStatusD;

class OrderBodyD extends StatelessWidget {
  const OrderBodyD({
    super.key,
    required this.idOrder,
    required this.idPackage,
    required this.numberOrder,
    required this.numberBill,
    required this.clock,
    required this.date,
    required this.numberItem,
    required this.infoPayment,
    required this.statusOrder,
  });
  final int idOrder;
  final int idPackage;
  final String numberOrder;
  final String numberBill;
  final String clock;
  final String date;
  final String numberItem;
  final String infoPayment;
  final String statusOrder;

  // @override
  @override
  Widget build(BuildContext context) {
    context.read<OrderDetailsCubit>().fetchOrderDetails(idPackage
        // , numberOrder,
        //     numberBill, clock, date, numberItem, infoPayment, statusOrder
        );
    Color orderColor;

    switch (infoPayment) {
      case 'Refunded':
        orderColor = Colors.yellow.shade50;
        break;
      case 'Paid':
        orderColor = Colors.green.shade50;
        break;
      case 'Unpaid':
        orderColor = Colors.red.shade50;
        break;
      default:
        orderColor = Colors.blue.shade50;
    }
    // final status = myStatuses[i];
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(16.r),
          ),
          height: 160.h,
          width: 380.w,
          child: Column(
            children: [
              TopInfoOrder(
                orderNumber: orderNumbers ?? '',
                billNumber: billNumbers ?? '',
                color: orderColors!,
              ),
              SizedBox(
                height: 10.h,
              ),
              BottomInfoOrder(
                  clock: clocks ?? '',
                  date: dates ?? '',
                  itemNumber: itemNumbers ?? ''),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('بيانات السداد : ', style: KTextStyle.textStyle12),
                    Text(paymentInfos ?? '', style: KTextStyle.textStyle12)
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
