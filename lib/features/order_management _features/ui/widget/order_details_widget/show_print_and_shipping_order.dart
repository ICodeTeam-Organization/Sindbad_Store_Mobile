import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/function/image_picker_function.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/build_info_row_add.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/drop_down_widget.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../manager/refresh/refresh_page_cubit.dart';
import '../order_shipping_widgets/build_shipping_dialog_content.dart';
import '../order_shipping_widgets/custom_order_print_dialog.dart';
import '../order_shipping_widgets/custom_order_shipping_dialog.dart';
import 'build_dialog_content.dart';
import 'messages.dart';

class ShowPrintAndShippingOrder extends StatelessWidget {
  const ShowPrintAndShippingOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int shippingNumber;
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
                        headTitle: 'بيانات فاتورة الشحن',
                        firstTitle: 'تاريخ الفاتورة',
                        secondTitle: 'رقم فاتورة الشحن',
                        thierdTitle: 'الشركة الناقلة',
                        onPressedSure: () async {
                          try {
                            await context
                                .read<ShippingCubit>()
                                .fetchOrderShipping(
                                    orderId: idOrders!,
                                    invoiceDate: dateConroller.text,
                                    shippingNumber: shippingNumber =
                                        int.parse(numberShippingConroller.text),
                                    shippingCompany: companyName ?? '',
                                    shippingImages: images!,
                                    numberParcels: parcels!);
                            dateConroller.clear();
                            numberShippingConroller.clear();
                            // Navigator.of(context).pop();
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return Messages(
                            //       isTrue: true,
                            //       trueMessage: 'لقد تم الشحن بنجاح',
                            //       falseMessage: 'هناك خطاء في العملية',
                            //     );
                            //   },
                            // );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('هنالك خطا ما  $e'),
                              ),
                            );
                          }
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BlocBuilder<ShippingCubit, ShippingState>(
                                builder: (context, state) {
                                  if (state is ShippingSuccess) {
                                    return Messages(
                                      isTrue: state.serverMessage.isSuccess,
                                      trueMessage:
                                          'لقد تمت الأضافة في قائمة التجهيز',
                                      falseMessage: 'هناك خطاء في العملية',
                                    );
                                  } else if (state is ShippingFailure) {
                                    return Messages(
                                      isTrue: false,
                                      trueMessage:
                                          'لقد تمت الأضافة في قائمة التجهيز',
                                      falseMessage: 'هناك خطاء في العملية',
                                    );
                                  } else {
                                    return Text("يوجد خطا");
                                  }
                                },
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
