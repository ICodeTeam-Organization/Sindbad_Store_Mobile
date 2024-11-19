import 'dart:io';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../core/styles/Colors.dart';
import '../widget/order_details_widget/custom_create_bill_dialog.dart';
import '../widget/order_details_widget/custom_order_cancle_dialog.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              CustomAppBar(
                tital: 'الطلب',
              ),
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(16.r)),
                height: 160.h,
                width: 380.w,
                child: Column(
                  children: [
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                          color: AppColors.grey,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text(
                                'رقم الطلب',
                                style: KTextStyle.textStyle11,
                              ),
                              Text(
                                '1111111111',
                                style: KTextStyle.textStyle14,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('رقم الفاتورة',
                                  style: KTextStyle.textStyle11),
                              Text(
                                '454645454',
                                style: KTextStyle.textStyle14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/alarm.svg",
                            width: 30.w,
                            height: 30.h,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            '4:15 - التاريخ 2024/11/17 ',
                            style: KTextStyle.textStyle12,
                          ),
                          SizedBox(
                            width: 70.w,
                          ),
                          SizedBox(
                            width: 40.w,
                            height: 40.h,
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SvgPicture.asset(
                                  "assets/Bag.svg",
                                  width: 40.w,
                                  height: 40.h,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "25",
                                  style: KTextStyle.textStyle12.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          Text('عدد الاصناف', style: KTextStyle.textStyle12),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Text('بيانات السداد : ',
                              style: KTextStyle.textStyle12),
                          Text('لا يوجد', style: KTextStyle.textStyle12)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ////////////////////////////////////////
              ///Order Detaials
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 12.0.w),
                      padding: EdgeInsets.all(10),
                      height: 320.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grey),
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Container(
                              width: 91.w,
                              height: 91.h,
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(8.r)),
                              child: Image.asset(
                                "assets/laptop.png",
                                width: 90.w,
                                height: 90.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  'اسم المنتج :  ',
                                  style: KTextStyle.textStyle14
                                      .copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'MacBook Air',
                                  style: KTextStyle.textStyle14
                                      .copyWith(fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'نوع المنتج :  ',
                                      style: KTextStyle.textStyle14.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'لابتوب',
                                      style: KTextStyle.textStyle14.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'القرص الصلب : ',
                                      style: KTextStyle.textStyle14.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      '512GB',
                                      style: KTextStyle.textStyle14.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Spacer(),
                                    Text('|'),
                                    Spacer(),
                                    Text(
                                      'الرام : 8GB',
                                      style: KTextStyle.textStyle14.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text('العدد : '),
                              Text(
                                '3',
                                style: KTextStyle.textStyle16
                                    .copyWith(color: AppColors.primary),
                              ),
                              SizedBox(
                                width: 50.w,
                              ),
                              Text('السعر : '),
                              Text(
                                '3',
                                style: KTextStyle.textStyle16
                                    .copyWith(color: AppColors.primary),
                              ),
                              Text('\$'),
                              Spacer(),
                              Text('الاجمالي'),
                              Container(
                                  padding: EdgeInsets.all(8.0),
                                  margin: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Row(
                                    children: [
                                      Text(
                                        '1000',
                                        style: KTextStyle.textStyle16
                                            .copyWith(color: AppColors.primary),
                                      ),
                                      Text('\$'),
                                    ],
                                  )),
                            ],
                          ),
                          Divider(),
                          BarcodeWidget(
                            height: 70.h,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            data: "45465121564",
                            textPadding: 8,
                            style: KTextStyle.textStyle14,
                            // data: orderNum.toString(), // Data here
                            barcode:
                                Barcode.code128(), // Specify the barcode type
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
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
                          return CustomCreateBillDialog(
                            headTitle: 'بيانات الفاتورة',
                            firstTitle: 'تاريخ الفاتورة',
                            secondTitle: 'رقم الفاتورة',
                            thierdTitle: 'قيمة الفاتورة',
                            onPressedSure: () {},
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
                            headTitle: ' ملاحظة رفض الطلب',
                            firstTitle: ' الفاتورة',
                            onPressedSure: () {},
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


///////////////////////////////////////////////////////////////


// class CustomIMageButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final IconData icon;
//   final String title;

//   const CustomIMageButton({
//     super.key,
//     required this.onTap,
//     required this.icon,
//     required this.title,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//         decoration: BoxDecoration(
//           color: Colors.grey,
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title,
//               style: KTextStyle.secondaryTitle.copyWith(color: AppColors.white),
//             ),
//             const SizedBox(width: 10),
//             Icon(
//               icon,
//               size: 25,
//               color: AppColors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
