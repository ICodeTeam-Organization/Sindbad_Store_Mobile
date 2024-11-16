import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/order/ui/screen/order.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int myIndex = 0;
  List<Widget> widgetList = [
    // Text('الطلبات'),
    Order(),
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
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          selectedItemColor: AppColors.black,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
                backgroundColor: AppColors.colorButton,
                icon: Icon(Icons.home),
                label: 'الطلبات'),
            BottomNavigationBarItem(
                backgroundColor: AppColors.colorButton,
                icon: Icon(Icons.home),
                label: 'المنتجات'),
            BottomNavigationBarItem(
                backgroundColor: AppColors.colorButton,
                icon: Icon(Icons.home),
                label: 'العروض'),
            BottomNavigationBarItem(
                backgroundColor: AppColors.colorButton,
                icon: Icon(Icons.home),
                label: 'التقارير'),
          ],
        ),
      ),
    );
  }
}
