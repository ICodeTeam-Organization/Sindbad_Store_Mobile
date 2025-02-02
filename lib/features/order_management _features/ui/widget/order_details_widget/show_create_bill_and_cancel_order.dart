import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/sub_custom_tab_bar.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_details_widget/build_dialog_content.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_details_widget/radio_widget.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../function/image_picker_function.dart';
import '../../manager/all_order/all_order_cubit.dart';
import '../../manager/cancel/cancel_cubit.dart';
import '../../manager/invoice/order_invoice_cubit.dart';
import 'custom_create_bill_dialog.dart';
import 'custom_order_cancle_dialog.dart';
import 'messages.dart';

class ShowCreateBillAndCancelOrder extends StatelessWidget {
  final VoidCallback onCreateInvoice; // New: Callback to trigger state update
  const ShowCreateBillAndCancelOrder(
      {super.key, required this.onCreateInvoice}); // Updated constructor

  DateTime? convertToDateTime(String inputDate) {
    try {
      DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(inputDate);
      DateTime dateWithTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        03,
        00,
        00,
        000,
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
    int? mount;
    int pays = 0;
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
                  return BlocConsumer<OrderInvoiceCubit, OrderInvoiceState>(
                    listener: (context, state) {
                      if (state is OrderInvoiceSuccess) {
                        // Trigger the callback to update the button state
                        //تحديث الصفحة بعد انشاء الفاتورة
                        refreshAfterCreateInvoice(context);
                        onCreateInvoice(); // New: Trigger Cubit state update
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('لقد تمت الأضافة في قائمة التجهيز')),
                        );
                        // Messages(
                        //   isTrue: state.serverMessage.isSuccess,
                        //   trueMessage: 'لقد تمت الأضافة في قائمة التجهيز',
                        //   falseMessage: 'هناك خطاء في العملية',
                        // );
                        Navigator.pop(context); // Close the dialog
                        Navigator.pop(context); // Close the dialog
                      } else if (state is OrderInvoiceFailuer) {
                        // Messages(
                        //   isTrue: false,
                        //   trueMessage: ' ',
                        //   falseMessage: 'هناك خطاء في العملية',
                        // );
                        Navigator.pop(context); // Close the dialog
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('هناك خطاء في العملية')),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is OrderInvoiceLoading) {
                        return CustomCreateBillDialog(
                          isLoading: true,
                          headTitle: 'بيانات الفاتورة',
                          firstTitle: 'تاريخ الفاتورة',
                          secondTitle: 'رقم الفاتورة',
                          thierdTitle: 'قيمة الفاتورة',
                          onPressedSure: () async {},
                        );
                      }

                      return CustomCreateBillDialog(
                        headTitle: 'بيانات الفاتورة',
                        firstTitle: 'تاريخ الفاتورة',
                        secondTitle: 'رقم الفاتورة',
                        thierdTitle: 'قيمة الفاتورة',
                        onPressedSure: () async {
                          DateTime? dateFormat =
                              convertToDateTime(dateConroller.text);
                          await context
                              .read<OrderInvoiceCubit>()
                              .fechOrderInvoice(
                                packageId: idPackages!,
                                invoiceAmount: mount =
                                    int.parse(mountConroller.text),
                                invoiceImage: images!,
                                invoiceNumber: numberConroller.text,
                                invoiceDate: dateFormat ?? DateTime.now(),
                                invoiceType: pays = int.parse(pay ?? '0'),
                              );
                          // Clear input fields
                          numberConroller.clear();
                          mountConroller.clear();
                          dateConroller.clear();
                        },
                      );
                    },
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
                        //! هذه الطريقة تجربة فقط اذا ضبطت او سيتم حذفها
                        if (context.mounted) {
                          context.pop();
                        }
                        if (context.mounted) {
                          context.pop();
                        }
                        // context.pop();
                        // context.pop();
                        //! هذه الطريقة تجربة فقط اذا ضبطت او سيتم حذفها
                        if (context.mounted) {
                          showDialog(
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
                          // Clear input fields
                          cancelConroller.clear();
                        }
                      } catch (e) {
                        //! هذه الطريقة تجربة فقط اذا ضبطت او سيتم حذفها
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('هنالك خطا ما  $e'),
                            ),
                          );
                          Navigator.of(context).pop();
                          showDialog(
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

  void refreshAfterCreateInvoice(BuildContext context) {
    int subTab = subTabController!.index;
    if (subTab == 0) {
      context.read<AllOrderCubit>().fetchAllOrder(
            isUrgen: false,
            canceled: false,
            delevred: false,
            noInvoice: false,
            unpaied: false,
            paied: false,
            pageNumber: 1,
            pageSize: 100,
            // srearchKeyword: ''
          );
    } else if (subTab == 1) {
      context.read<AllOrderCubit>().fetchAllOrder(
            isUrgen: false,
            canceled: false,
            delevred: false,
            noInvoice: true,
            unpaied: false,
            paied: false,
            pageNumber: 1,
            pageSize: 100,
            // srearchKeyword: ''
          );
    }
  }
}
