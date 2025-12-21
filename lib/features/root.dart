import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/features/custom_bottom_navigation_bar.dart';
import 'package:sindbad_management_app/features/offers_features/ui/screens/view_offer_screen.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/orders_tabbar_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/reports_offer_index.dart';

import 'products_feature/view_product_features/ui/widgets/products_tabbat_widget.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  /// The current index of the selected item or page.
  /// Initialized to 0 by default.
  ///
  @override
  void initState() {
    super.initState();

    /// initilization the categories in the cubit
    /// this line invoke fetchDataFromApi methof from the category cubit
    context.read<GetCategoryNamesCubit>().fetchDataFromApi();
  }

  int myIndex = 0;

  List<Widget> widgetList = [
    OrderManagementWidget(),
    ProductsTabBatWidget(),
    ViewOfferScreen(),
    ViewReportsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Scaffold(
        // Enable swipe from left to right to open drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text(
                  'القائمة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('الرئيسية'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('الملف الشخصي'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to profile
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('الإعدادات'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to settings
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('تسجيل الخروج'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            // Main content (IndexedStack)
            IndexedStack(
              index: myIndex,
              children: widgetList,
            ),
            // CustomBottomNavigationBar positioned at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomBottomNavigationBar(
                currentIndex: myIndex,
                onTap: (index) {
                  setState(() {
                    myIndex = index;
                  });
                  // if (index == 2) {
                  //   context.read<OfferCubit>().getOffer(100, 1);
                  // }
                },
                items: [
                  CustomBottomNavigationBarItem(
                    icon: 'assets/logo_orders.svg',
                    label: l10n.orders,
                  ),
                  CustomBottomNavigationBarItem(
                    icon: 'assets/logo_products.svg',
                    label: 'المنتجات',
                  ),
                  CustomBottomNavigationBarItem(
                    icon: 'assets/logo_offers.svg',
                    label: 'العروض',
                  ),
                  CustomBottomNavigationBarItem(
                    icon: 'assets/logo_reports.svg',
                    label: 'التقارير',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
