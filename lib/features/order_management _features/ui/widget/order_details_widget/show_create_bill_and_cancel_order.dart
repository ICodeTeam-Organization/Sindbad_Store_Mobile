import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/sub_custom_tab_bar.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_body.dart';
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

class ShowCreateBillAndCancelOrder extends StatefulWidget {
  const ShowCreateBillAndCancelOrder({super.key});
  @override
  State<ShowCreateBillAndCancelOrder> createState() =>
      _ShowCreateBillAndCancelOrderState();
}

class _ShowCreateBillAndCancelOrderState
    extends State<ShowCreateBillAndCancelOrder> {
  // Updated constructor
  TextEditingController dateController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController mountController = TextEditingController();

  TextEditingController cancelController = TextEditingController();
  @override
  void dispose() {
    dateController.dispose();
    numberController.dispose();
    mountController.dispose();
    cancelController.dispose();
    super.dispose();
  }

  DateTime? convertToDateTime(String inputDate) {
    try {
      if (images == null) {
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
      }
    } catch (e) {
      // Return null if the input is invalid
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        //!تحديث الصفحة بعد انشاء الفاتورة
                        refreshAfterCreateInvoice(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.serverMessage.serverMessage),
                          ),
                        );
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else if (state is OrderInvoiceFailuer) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.errMessage)),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is OrderInvoiceLoading) {
                        return CustomCreateBillDialog(
                          isLoading: true,
                          dateController: dateController,
                          numberController: numberController,
                          mountController: mountController,
                          onPressedSure: () async {},
                        );
                      }

                      return CustomCreateBillDialog(
                        dateController: dateController,
                        numberController: numberController,
                        mountController: mountController,
                        onPressedSure: () async {
                          if (images == null &&
                              (dateController.text.isEmpty ||
                                  numberController.text.isEmpty ||
                                  mountController.text.isEmpty)) {
                            if (images == null &&
                                (dateController.text.isEmpty ||
                                    numberController.text.isEmpty ||
                                    mountController.text.isEmpty)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('خطأ'),
                                    content: Text(
                                        'يرجى إدخال جميع البيانات المطلوبة أو إدراج صورة.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('حسناً'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            } else if (images != null) {
                              return;
                            }
                          }
                          ;
                          DateTime? dateFormat =
                              convertToDateTime(dateController.text);
                          await context
                              .read<OrderInvoiceCubit>()
                              .fechOrderInvoice(
                                packageId: idPackages,
                                invoiceAmount: mountController.text.isEmpty
                                    ? 0.0
                                    : double.parse(mountController.text),
                                invoiceImage: images!,
                                invoiceNumber: numberController.text,
                                invoiceDate: dateFormat ?? DateTime.now(),
                                invoiceType: int.parse(pay ?? '0'),
                              );
                          numberController.clear();
                          mountController.clear();
                          dateController.clear();
                          images = null;
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
                    cancelConroller: cancelController,
                    headTitle: 'ملاحظة رفض الطلب',
                    onPressedSure: () async {
                      try {
                        await context.read<CancelCubit>().fetchOrderCancel(
                            orderId: idOrders!,
                            orderCancel: true,
                            reasonCancel: cancelController.text);
                        if (context.mounted) {
                          context.pop();
                          context.pop();
                        }
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
                          cancelController.clear();
                        }
                      } catch (e) {
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
    int tab = tabController!.index;
    if (subTab == 0) {
      context.read<AllOrderCubit>().fetchAllOrder(
            statuses: [2,3,4],
            isUrgent: tab == 1,
            pageNumber: 1,
            pageSize: 10,
          );
    } else if (subTab == 1) {
      context.read<AllOrderCubit>().fetchAllOrder(
            statuses: [2],
            isUrgent: tab == 1,
            pageNumber: 1,
            pageSize: 10,
          );
    }
  }
}
