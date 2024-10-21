import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/widgets/custom_data_dialog_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_print_dialog_widget.dart';

class StoreButtonListViewFunction extends StatelessWidget {
  const StoreButtonListViewFunction({super.key});

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
            KCustomPrimaryButtonWidget(
                buttonName: "الفاتورة",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const CustomDataDialogWidget(
                          headTitle: 'بيانات الفاتورة',
                          firstTitle: 'التاريخ',
                          firstTitleContent: '2024/10/2',
                          secondTitle: 'رقم الفاتورة',
                          secondTitleContent: '2102511025',
                          thierdTitle: 'قيمة الفاتورة',
                          thierdTitleContent: '125.00',
                        );
                      });
                }),
            SizedBox(
              width: 50.w,
            ),
            KCustomPrimaryButtonWidget(
                buttonName: "طباعة عنوان الطلب",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const KCustomPrintDialogWidget(
                            numberOfCopies: 2, printName: "");
                      });
                }),
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                KCustomPrimaryButtonWidget(
                    buttonName: "تم ارسال الطلب",
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const CustomDataDialogWidget(
                              headTitle: 'بيانات الشحن',
                              firstTitle: 'التاريخ',
                              firstTitleContent: '2024/10/2',
                              secondTitle: 'رقم فاتورة الشحن',
                              secondTitleContent: '2102511025',
                              thierdTitle: 'شركة النقل',
                              thierdTitleContent: 'اسم الشركة الناقلة',
                            );
                          });
                    }),
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
            ),
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
            content: Container(
              height: 30.h,
              child: const Text(
                "هل تريد الغاء الطلب؟",
                style: TextStyle(color: Colors.black),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.r)),
                  child: const Text(
                    "موافق",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25.r)),
                  child: const Text(
                    "تراجع",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          );
        });
  }
}
