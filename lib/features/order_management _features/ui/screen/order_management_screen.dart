import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              CustomAppBar(
                onPressed: () {},
                tital: 'قائمة الطلبات',
              ),
              SizedBox(height: 5),
              Expanded(
                child: CustomTabBarWidget(
                  length: 4,
                  tabs: [
                    Tab(
                      child: Text('الجديدة'),
                    ),
                    Tab(
                      child: Text('المستعجلة'),
                    ),
                    Tab(
                      child: Text('السابقة'),
                    ),
                    Tab(
                      child: Text('الملغية'),
                    ),
                  ],
                  tabViews: [
                    CustomTabBarWidget(
                      length: 5,
                      tabs: [
                        Tab(
                          child: Text('الكل'),
                        ),
                        Tab(
                          child: Text('بدون فاتورة'),
                        ),
                        Tab(
                          child: Text('لم تسدد'),
                        ),
                        Tab(
                          child: Text('للتجهيز'),
                        ),
                        Tab(
                          child: Text('للشحن'),
                        ),
                      ],
                      tabViews: [
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
                                        borderRadius:
                                            BorderRadius.circular(16.r)),
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
