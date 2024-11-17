import 'package:flutter/material.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomAppBar(
                onPressed: () {},
                title: 'قائمة الطلبات',
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
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                        Text('data'),
                      ],
                    ),
                    Text('data'),
                    Text('data'),
                    Text('data'),
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
