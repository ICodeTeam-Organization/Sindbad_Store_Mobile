import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/action_button_order_cancle.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/button_bill.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/button_order_send.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/widget/button_print_order_title.dart';

class StoreButtonList extends StatelessWidget {
  const StoreButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ButtonBill(
              billDate: '2024/10/2',
              billNumber: '2102511025',
              billMount: '125.00',
            ),
            SizedBox(
              width: 50.w,
            ),
            const ButtonPrintOrderTitle(),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ButtonOrderSend(),
            SizedBox(
              width: 50.w,
            ),
            KCustomPrimaryButtonWidget(
              buttonName: "الغاء الطلب",
              onPressed: () {
                orderCancle(context);
              },
            )
          ],
        )
      ],
    );
  }

  void orderCancle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              height: 30.h,
              child: const Text(
                "هل تريد الغاء الطلب؟",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              ActionButtonOrderCancle(
                title: 'موافق',
                onTap: () {},
              ),
              ActionButtonOrderCancle(
                title: 'تراجع',
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
