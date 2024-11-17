import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              tital: 'قائمة الطلبات',
            )
          ],
        ),
      ),
    );
  }
}
