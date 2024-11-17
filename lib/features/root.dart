import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/order/ui/screen/primary_button.dart';

import 'order_management _features/ui/screen/order_management_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int myIndex = 0;
  List<Widget> widgetList = [
    // Text('الطلبات'),
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
      bottomNavigationBar: Container(
        height: 100,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            // border: Border.all(color: AppColors.black),
            borderRadius: BorderRadius.circular(50)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: AppColors.colorButton,
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
                label: 'الطلبات'),
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
