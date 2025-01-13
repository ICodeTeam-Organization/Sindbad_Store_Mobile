import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
// import 'order_management _features/ui/screen/order_management_screen.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/screens/view_offer_screen.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/screen/order_management_screen.dart';
import 'product_features/view_product_features/ui/screens/view_product_screen.dart';

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
  static const double _bottomNavBarHeight = 105.0;
  static const double _paddingAndMagin = 10.0;
  static const double _borderRadius = 50.0;

  List<Widget> widgetList = [
    OrderManagementScreen(),
    ViewProductScreen(),
    ViewOfferScreen(),
    Center(child: Text('التقارير')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: widgetList,
      ),
      bottomNavigationBar: Container(
        height: _bottomNavBarHeight.h,
        padding: EdgeInsets.symmetric(
            horizontal: _paddingAndMagin.w, vertical: _paddingAndMagin.h),
        margin: EdgeInsets.symmetric(
            horizontal: _paddingAndMagin.w, vertical: _paddingAndMagin.h),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(_borderRadius.r)),
        child: BottomNavigationBar(
          backgroundColor: AppColors.white,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle: KTextStyle.textStyle12,
          unselectedLabelStyle: KTextStyle.textStyle12,
          // selectedIconTheme: const IconThemeData(
          //   color: AppColors.primary, // Set selected icon color
          // ),
          // unselectedIconTheme: const IconThemeData(
          //   color: AppColors.greyDark, // Set selected icon color
          // ),
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.greyDark,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          currentIndex: myIndex,
          items: [
            BottomNavigationBarItem(
              backgroundColor: AppColors.white,
              icon: Container(
                padding: EdgeInsets.all(3),
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: myIndex == 0 ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                ),
                child: SvgPicture.asset('assets/logo_orders.svg',
                    color: myIndex == 0 ? AppColors.white : AppColors.primary),
              ),
              label: 'الطلبات',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppColors.white,
              icon: Container(
                padding: EdgeInsets.all(3),
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: myIndex == 1 ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                ),
                child: SvgPicture.asset('assets/logo_products.svg',
                    color: myIndex == 1 ? AppColors.white : AppColors.primary),
              ),
              label: 'المنتجات',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppColors.white,
              icon: Container(
                padding: EdgeInsets.all(3),
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: myIndex == 2 ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                  // borderRadius: BorderRadius.circular(5),
                ),
                child: SvgPicture.asset('assets/logo_offers.svg',
                    color: myIndex == 2 ? AppColors.white : AppColors.primary),
              ),
              label: 'العروض',
            ),
            BottomNavigationBarItem(
              backgroundColor: AppColors.white,
              icon: Container(
                padding: EdgeInsets.all(3),
                height: 40.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: myIndex == 3 ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(5),
                  ),
                ),
                child: SvgPicture.asset('assets/logo_reports.svg',
                    color: myIndex == 3 ? AppColors.white : AppColors.primary),
              ),
              label: 'التقارير',
            ),
          ],
        ),
      ),
    );
  }
}
