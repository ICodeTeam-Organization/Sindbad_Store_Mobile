import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'order_management _features/ui/screen/order_management_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  /// The current index of the selected item or page.
  /// Initialized to 0 by default.
  int myIndex = 0;

  // Constants for repeated values
  static const double _bottomNavBarHeight = 100.0;
  static const double _paddingAndMagin = 10.0;
  static const double _borderRadius = 50.0;

  List<Widget> widgetList = [
    OrderManagementScreen(),
    Text('المنتجات'),
    Text('العروض'),
    Text('التقارير'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: widgetList,
      ),
      bottomNavigationBar:

          /// [qais] => The bottom navigation bar container.
          /// Note: Avoid using `Container` beacause it is a heavy widget.
          /// Consider using `Padding`, `DecoratedBox`, and `SizedBox` instead
          /// for better performance.

          Container(
        height: _bottomNavBarHeight.h,
        padding: EdgeInsets.symmetric(
            horizontal: _paddingAndMagin.h, vertical: _paddingAndMagin.w),
        margin: EdgeInsets.symmetric(
            horizontal: _paddingAndMagin.h, vertical: _paddingAndMagin.w),
        decoration: BoxDecoration(
            // border: Border.all(color: AppColors.black),
            borderRadius: BorderRadius.circular(_borderRadius.r)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: AppColors.redDark,
          unselectedItemColor: AppColors.black,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.home),
                label: 'المنتجات'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.home),
                label: 'العروض'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.home),
                label: 'التقارير'),
          ],
        ),
      ),
    );
  }
}
