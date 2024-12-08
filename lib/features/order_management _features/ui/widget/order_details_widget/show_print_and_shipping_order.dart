import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
  DateTime? convertToDateTime(String inputDate) {
    try {
      // Parse the input date string
      DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(inputDate);

      // Add the desired time component
      DateTime dateWithTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        03, // Hour
        00, // Minute
        00, // Second
        000, // Milliseconds
      );

      // Return the DateTime in UTC
      return dateWithTime.toUtc();
    } catch (e) {
      // Return null if the input is invalid
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
                icon: Icons.local_shipping_outlined,
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
                            DateTime? dateFormat =
                                convertToDateTime(dateConroller.text);
                            await context
                                .read<ShippingCubit>()
                                .fetchOrderShipping(
                                    orderId: idOrders!,
                                    invoiceDate: dateFormat ?? DateTime.now(),
                                    shippingNumber: shippingNumber =
                                        int.parse(numberShippingConroller.text),
                                    shippingCompany: companyName ?? '',
                                    shippingImages: images!,
                                    numberParcels: parcels!);
                            print(
                                '$dateFormat DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDaAAAAAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTTTeEEEEEEEEEEE');
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            showDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (context) {
                                return BlocBuilder<ShippingCubit,
                                    ShippingState>(
                                  builder: (context, state) {
                                    if (state is ShippingSuccess) {
                                      return Messages(
                                        isTrue: state.serverMessage.isSuccess,
                                        trueMessage: 'لقد تم الشحن بنجاح',
                                        falseMessage: 'هناك خطاء في العملية',
                                      );
                                    } else if (state is ShippingFailure) {
                                      return Messages(
                                        isTrue: false,
                                        trueMessage: 'لقد تم الشحن بنجاح',
                                        falseMessage: 'هناك خطاء في العملية',
                                      );
                                    } else {
                                      return Text("يوجد خطا");
                                    }
                                  },
                                );
                              },
                            );
                            dateConroller.clear();
                            numberShippingConroller.clear();
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            // ScaffoldMessenger.of(context).showSnackBar(
                            //   SnackBar(
                            //     content: Text('هنالك خطا ما  $e'),
                            //   ),
                            // );
                            // ignore: use_build_context_synchronously
                            // Navigator.of(context).pop();
                            showDialog(
                              // ignore: use_build_context_synchronously
                              context: context,
                              builder: (context) {
                                return BlocBuilder<ShippingCubit,
                                    ShippingState>(
                                  builder: (context, state) {
                                    if (state is ShippingSuccess) {
                                      return Messages(
                                        isTrue: false,
                                        trueMessage: '',
                                        falseMessage: 'هناك خطاء في العملية',
                                      );
                                    } else if (state is ShippingFailure) {
                                      return Messages(
                                        isTrue: false,
                                        trueMessage: '',
                                        falseMessage: 'هناك خطاء في العملية',
                                      );
                                    } else {
                                      return Text("يوجد خطا");
                                    }
                                  },
                                );
                              },
                            );
                          }
                        },
                      );
                    },
                  );
                },
              ),
              StorePrimaryButton(
                icon: Icons.receipt_long_outlined,
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
                        // طباعة باركود عبر رقم الفاتورة و رقم المحل
                        billNumber: int.parse(billNumbers ?? '0'),
                        storeNumber: 777777778,
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
