import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

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

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.tital,
  });
  final String tital;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primaryBackground,
      centerTitle: true,
      title: Text(
        tital,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey, width: 2),
                borderRadius: BorderRadius.circular(16),
                color: AppColors.primaryBackground),
            child: IconButton(
              onPressed: () {},
              iconSize: 24,
              icon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}
