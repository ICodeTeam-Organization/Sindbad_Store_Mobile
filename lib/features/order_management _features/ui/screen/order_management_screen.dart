import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../core/shared_widgets/new_widgets/sub_custom_tab_bar.dart';
import '../../../../core/styles/text_style.dart';
import '../../../../core/utils/route.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              CustomAppBar(
                tital: 'قائمة الطلبات',
              ),
              SizedBox(height: 5),
              Expanded(
                child: CustomTabBarWidget(
                  length: 4,
                  tabs: [
                    Tab(
                      child: Text('الجديدة', style: KTextStyle.textStyle16),
                    ),
                    Tab(
                      child: Text('المستعجلة', style: KTextStyle.textStyle16),
                    ),
                    Tab(
                      child: Text('السابقة', style: KTextStyle.textStyle16),
                    ),
                    Tab(
                      child: Text('الملغية', style: KTextStyle.textStyle16),
                    ),
                  ],
                  tabViews: [
                    //New tabViews
                    SubCustomTabBar(
                      length: 5,
                      tabs: [
                        Tab(
                          child: Text('الكل',
                              style: KTextStyle.textStyle14
                                  .copyWith(fontWeight: FontWeight.w500)),
                        ),
                        Tab(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Positioned(
                                width: 110,
                                child: Text('بدون فاتورة',
                                    style: KTextStyle.textStyle11
                                        .copyWith(fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                        Tab(
                          child: Text(
                            'لم تسدد',
                            style: KTextStyle.textStyle14
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Tab(
                          child: Text('للتجهيز',
                              style: KTextStyle.textStyle14
                                  .copyWith(fontWeight: FontWeight.w500)),
                        ),
                        Tab(
                          child: Text('للشحن',
                              style: KTextStyle.textStyle14
                                  .copyWith(fontWeight: FontWeight.w500)),
                        ),
                      ],
                      tabViews: [
                        InfoOrder(),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                    Text('data'),
                    Text('data'),
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(16.r)),
                          height: 130.h,
                          width: 380.w,
                          child: Column(
                            children: [
                              Container(
                                height: 60.h,
                                decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(16.r)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoOrder extends StatelessWidget {
  const InfoOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            context.push(
              AppRouter.storeRouters.details,
              // extra: idOrder,
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10.h),
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
                          Text('رقم الفاتورة', style: KTextStyle.textStyle11),
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
                      Text('بيانات السداد : ', style: KTextStyle.textStyle12),
                      Text('لا يوجد', style: KTextStyle.textStyle12)
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
