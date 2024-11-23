import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../manager/cubit/refresh_page_cubit.dart';
import 'custom_create_bill_dialog.dart';
import 'custom_order_cancle_dialog.dart';
import 'messages.dart';

class ShowCreateBillAndCancelOrder extends StatelessWidget {
  const ShowCreateBillAndCancelOrder({super.key});

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
                      onPressedSure: () {
                        context.read<RefreshPageCubit>().refreshpage();
                        Navigator.of(context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Messages(
                              isTrue: true,
                              trueMessage: 'لقد تمت الأضافة في قائمة التجهيز',
                              falseMessage: 'هناك خطاء في العملية',
                            );
                          },
                        );
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
