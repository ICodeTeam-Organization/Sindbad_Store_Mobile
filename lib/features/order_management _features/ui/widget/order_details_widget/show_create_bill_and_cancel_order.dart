import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../function/image_picker_function.dart';
import '../../manager/cancel/cancel_cubit.dart';
import '../../manager/refresh/refresh_page_cubit.dart';
import '../../manager/invoice/order_invoice_cubit.dart';
import 'build_dialog_content.dart';
import 'custom_create_bill_dialog.dart';
import 'custom_order_cancle_dialog.dart';
import 'messages.dart';
import 'radio_widget.dart';

// ignore: must_be_immutable
class ShowCreateBillAndCancelOrder extends StatelessWidget {
  ShowCreateBillAndCancelOrder({super.key});
  int? mount;
  int pays = 0;
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
    RefreshPageCubit refPageCubit = RefreshPageCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StorePrimaryButton(
            width: 160.w,
            title: 'انشاء فاتورة',
            buttonColor: AppColors.greenOpacity,
            textColor: AppColors.greenDark,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return BlocListener<RefreshPageCubit, RefreshPageState>(
                    listener: (context, state) {},
                    child: CustomCreateBillDialog(
                      headTitle: 'بيانات الفاتورة',
                      firstTitle: 'تاريخ الفاتورة',
                      secondTitle: 'رقم الفاتورة',
                      thierdTitle: 'قيمة الفاتورة',
                      onPressedSure: () async {
                        // Navigator.of(context).pop();

                        try {
                          DateTime? dateFormat =
                              convertToDateTime(dateConroller.text);
                          // Helper function to format DateTime
                          // String? formatDateTime(DateTime? dateTime) {
                          //   if (dateTime == null) return null;
                          //   return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                          //       .format(dateTime.toUtc());
                          // }

                          // if (dateFormat != null) {
                          // print(
                          //     '${formatDateTime(dateFormat)}***************************'); // Output: 2024-12-03T09:55:12.120Z
                          // } else {
                          //   print("Invalid date format");
                          //   return; // Exit if dates are invalid
                          // }
                          await context
                              .read<OrderInvoiceCubit>()
                              .fechOrderInvoice(
                                orderId: idOrders!,
                                invoiceAmount: mount =
                                    int.parse(mountConroller.text),
                                invoiceImage: images!,
                                invoiceNumber: numberConroller.text,
                                invoiceDate: dateFormat ?? DateTime.now(),
                                //  dateConroller.text,

                                invoiceType: pays = int.parse(pay ?? '0'),

                                // dateConroller.text
                              );
                          print(
                              '$dateFormat***********************QQQQQQQQQQQqqqqqqqqqqqqqQQQQQQQQQQ****');
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) {
                              return BlocBuilder<OrderInvoiceCubit,
                                  OrderInvoiceState>(
                                builder: (context, state) {
                                  if (state is OrderInvoiceSuccess) {
                                    return Messages(
                                      isTrue: state.serverMessage.isSuccess,
                                      trueMessage:
                                          'لقد تمت الأضافة في قائمة التجهيز',
                                      falseMessage: 'هناك خطاء في العملية',
                                    );
                                  } else if (state is OrderInvoiceFailuer) {
                                    return Messages(
                                      isTrue: false,
                                      trueMessage: ' ',
                                      falseMessage: 'هناك خطاء في العملية',
                                    );
                                  } else {
                                    return Text("يوجد خطا");
                                  }
                                },
                              );
                            },
                          );
                          numberConroller.clear();
                          mountConroller.clear();
                          mountConroller.clear();
                          dateConroller.clear();

                          refPageCubit.refreshpage();
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text('هنالك خطا ما  $e'),
                          //   ),
                          // );
                          // Navigator.of(context).pop();
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) {
                              return BlocBuilder<OrderInvoiceCubit,
                                  OrderInvoiceState>(
                                builder: (context, state) {
                                  if (state is OrderInvoiceSuccess) {
                                    return Messages(
                                      isTrue: false,
                                      trueMessage: '',
                                      falseMessage: 'هناك خطاء في العملية',
                                    );
                                  } else if (state is OrderInvoiceFailuer) {
                                    return Messages(
                                      isTrue: false,
                                      trueMessage: ' ',
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
                    ),
                  );
                },
              );
            },
          ),
          StorePrimaryButton(
            width: 160.w,
            title: 'رفض الطلب',
            buttonColor: AppColors.redOpacity,
            textColor: AppColors.redColor,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomOrderCancleDialog(
                    headTitle: 'ملاحظة رفض الطلب',
                    onPressedSure: () async {
                      try {
                        await context.read<CancelCubit>().fetchOrderCancel(
                            orderId: idOrders!,
                            orderCancel: true,
                            reasonCancel: cancelConroller.text);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (context) {
                            return BlocBuilder<CancelCubit, CancelState>(
                              builder: (context, state) {
                                if (state is CancelSuccess) {
                                  return Messages(
                                    isTrue: state.serverMessage.isSuccess,
                                    trueMessage: 'لقد تم ارسال رفض طلب',
                                    falseMessage: '',
                                  );
                                } else if (state is CancelFailure) {
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
                        cancelConroller.clear();
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('هنالك خطا ما  $e'),
                          ),
                        );
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (context) {
                            return BlocBuilder<CancelCubit, CancelState>(
                              builder: (context, state) {
                                if (state is CancelSuccess) {
                                  return Messages(
                                    isTrue: false,
                                    trueMessage: '',
                                    falseMessage: 'هناك خطاء في العملية',
                                  );
                                } else if (state is CancelFailure) {
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
        ],
      ),
    );
  }
}
