import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
import '../../../../../core/styles/Colors.dart';
import 'bottom_order_details.dart';
import 'mid_order_details.dart';
import 'top_order_details.dart';

class OrderDetailsBody extends StatefulWidget {
  const OrderDetailsBody({
    super.key,
    required this.idOrder,
    required this.numberOrder,
    required this.numberBill,
    required this.clock,
    required this.date,
    required this.numberItem,
    required this.infoPayment,
    required this.statusOrder,
  });
  final int idOrder;
  final String numberOrder;
  final String numberBill;
  final String clock;
  final String date;
  final String numberItem;
  final String infoPayment;
  final String statusOrder;

  @override
  State<OrderDetailsBody> createState() => _OrderDetailsBodyState();
}

List<int>? orderDetailsID;

class _OrderDetailsBodyState extends State<OrderDetailsBody> {
  @override
  void initState() {
    super.initState();
    context.read<OrderDetailsCubit>().fetchOrderDetails(
        widget.idOrder,
        widget.numberOrder,
        widget.numberBill,
        widget.clock,
        widget.date,
        widget.numberItem,
        widget.infoPayment,
        widget.statusOrder);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
        if (state is OrderDetailsSuccess) {
          return ListView.builder(
            itemCount: state.orderDetails.length,
            itemBuilder: (context, i) {
              return Container(
                margin:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.0.w),
                padding: EdgeInsets.all(10),
                height: 244.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                child: Column(
                  children: [
                    //Dispaly image and product
                    TopOrderDetails(
                      orderDetailsId: state.orderDetails[i].idProduct,
                      imageUrl: state.orderDetails[i].imageUrl,
                      productName: state.orderDetails[i].nameProduct,
                      productType: state.orderDetails[i].nameCategory,
                      productNameCat1: state.orderDetails[i].nameAttribute1,
                      productTypeCat1: state.orderDetails[i].valueAttribute1,
                      productNameCat2: state.orderDetails[i].nameAttribute2,
                      productTypeCat2: state.orderDetails[i].valueAttribute2,
                    ),
                    //dispaly amount , price and total
                    MidOrderDetails(
                      productMount: state.orderDetails[i].quantityProduct,
                      productPrice: state.orderDetails[i].priceProduct,
                    ),
                    /////////////
                    Divider(),
                    //Display barcode
                    BottomOrderDetails(
                      barcodeNumber: state.orderDetails[i].numberProduct,
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is OrderDetailsFailure) {
          return Text(state.errMessage);
        } else if (state is OrderDetailsLoading) {
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
          return Text("هنالك خطا ما ");
        }
      }),
    );
  }
}
