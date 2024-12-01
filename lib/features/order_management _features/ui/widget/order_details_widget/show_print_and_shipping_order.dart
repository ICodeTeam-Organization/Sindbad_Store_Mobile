import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../manager/refresh/refresh_page_cubit.dart';
import '../order_shipping_widgets/custom_order_print_dialog.dart';
import '../order_shipping_widgets/custom_order_shipping_dialog.dart';
import 'messages.dart';

class ShowPrintAndShippingOrder extends StatelessWidget {
  const ShowPrintAndShippingOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefreshPageCubit, RefreshPageState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StorePrimaryButton(
                width: 160.w,
                title: 'شحن الطلب',
                icon: Icons.fire_truck,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomOrderShippingDialog(
                        parcels: 0,
                        headTitle: 'بيانات فاتورة الشحن',
                        firstTitle: 'تاريخ الفاتورة',
                        secondTitle: 'رقم فاتورة الشحن',
                        thierdTitle: 'الشركة الناقلة',
                        onPressedSure: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Messages(
                                isTrue: true,
                                trueMessage: 'لقد تم الشحن بنجاح',
                                falseMessage: 'هناك خطاء في العملية',
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
              StorePrimaryButton(
                icon: Icons.edit_document,
                width: 160.w,
                title: 'طباعة العنوان',
                // buttonColor: AppColors.redOpacity,
                // textColor: AppColors.redColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomOrderPrintDialog(
                        headTitle: '  طباعة عنوان الطلب',
                        onPressedPrint: () {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Messages(
                                isTrue: true,
                                trueMessage:
                                    'لقد تم طباعة ملصق انتقل الى شحن الطلبات',
                                falseMessage: 'هناك خطاء في العملية',
                              );
                            },
                          );
                        },
                        onPressedShare: () {},
                        //عدد النسخ
                        parcels: 3,
                        // طباعة باركود عبر رقم الفاتورة و رقم المحل
                        billNumber: 1111111111,
                        storeNumber: 25,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
