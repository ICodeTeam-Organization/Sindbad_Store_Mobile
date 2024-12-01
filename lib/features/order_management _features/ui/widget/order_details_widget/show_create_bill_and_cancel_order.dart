import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../function/image_picker_function.dart';
import '../../manager/refresh/refresh_page_cubit.dart';
import '../../manager/invoice/order_invoice_cubit.dart';
import 'custom_create_bill_dialog.dart';
import 'custom_order_cancle_dialog.dart';
import 'messages.dart';
import 'order_details_body.dart';
import 'radio_widget.dart';

class ShowCreateBillAndCancelOrder extends StatelessWidget {
  ShowCreateBillAndCancelOrder({super.key});
  num? mount;
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
                  return BlocListener<RefreshPageCubit, RefreshPageState>(
                    listener: (context, state) {},
                    child: CustomCreateBillDialog(
                      headTitle: 'بيانات الفاتورة',
                      firstTitle: 'تاريخ الفاتورة',
                      secondTitle: 'رقم الفاتورة',
                      thierdTitle: 'قيمة الفاتورة',
                      onPressedSure: () async {
                        Navigator.of(context).pop();
                        showDialog(
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
                        try {
                          await context
                              .read<OrderInvoiceCubit>()
                              .fechOrderInvoice(
                                  ids ?? [],
                                  mount = num.parse(mountConroller.text),
                                  images!,
                                  numberConroller.text,
                                  DateTime.now(),
                                  int.parse(pay ?? '0')

                                  // dateConroller.text
                                  );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('تم انشاء فاتورة بنجاح '),
                            ),
                          );
                          Navigator.of(context).pop();
                          numberConroller.clear();
                          mountConroller.clear();
                          mountConroller.clear();
                          dateConroller.clear();
                          print(
                              'amarrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('هنالك خطا ما  $e'),
                            ),
                          );
                          print('ikjgtiorjijjguiwheiruthwuiertywuorie $images');
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
                    onPressedSure: () {
                      Navigator.of(context).pop();
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
