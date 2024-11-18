import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../core/styles/Colors.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppBar(
            title: 'الطلب',
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(16.r)),
            height: 170.h,
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
                          Text('رقم الطلب'),
                          Text('1111111111'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('رقم الفاتورة'),
                          Text('454645454'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.w,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.alarm),
                      Text(' 4:15 - 2024/11/17 '),
                      SizedBox(
                        width: 80.w,
                      ),
                      SizedBox(
                        width: 37.5.w,
                        height: 35.h,
                        child: Stack(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: SvgPicture.asset(
                              // "assets/Bag.svg",
                              'assets/Bag.svg',
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                          CircleAvatar(
                            radius: 12.5,
                            backgroundColor: AppColors.grey,
                            child: Text(
                              "25",
                              style: KTextStyle.textStyle12.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Text('عدد الاصناف'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [Text('بيانات السداد : '), Text('لا يوجد')],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
