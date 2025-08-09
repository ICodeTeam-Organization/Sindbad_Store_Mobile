import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import '../widget/order_management_widget/bottom_info_order.dart';
import '../widget/order_management_widget/top_info_order.dart';
import 'order_body.dart';

class OrderBodyDetails extends StatelessWidget {
  const OrderBodyDetails({
    super.key,
    required this.idOrder,
    required this.idPackage,
    required this.numberOrder,
    required this.numberBill,
    required this.date,
    required this.numberItem,
    required this.infoPayment,
    required this.statusOrder,
  });
  final int idOrder;
  final int idPackage;
  final String numberOrder;
  final String numberBill;
  final String date;
  final String numberItem;
  final String infoPayment;
  final String statusOrder;

  // @override
  @override
  Widget build(BuildContext context) {
    context.read<OrderDetailsCubit>().fetchOrderDetails(idOrder);
    return BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(16.r),
          ),
          height: 160.h,
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              TopInfoOrder(
                orderNumber: orderNumbers ?? '',
                billNumber: billNumbers ?? '',
                color: orderColors ?? Colors.white,
              ),
              SizedBox(
                height: 10.h,
              ),
              BottomInfoOrder(date: dates ?? '', itemNumber: itemNumbers ?? ''),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text('بيانات السداد : ', style: KTextStyle.textStyle12),
                    Text(paymentInfos ?? '', style: KTextStyle.textStyle12),
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
