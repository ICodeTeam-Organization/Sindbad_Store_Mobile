import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/custom_bottom_navigation_bar.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/screens/view_offer_screen.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/screen/profile_screen.dart';
// import 'order_management _features/ui/screen/order_management_screen.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/orders_tabbar_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/reports_offer_index.dart';
import 'products_feature/view_product_features/ui/widgets/products_tabbat_widget.dart';

/// Global key for the root scaffold to access drawer from custom app bar
final GlobalKey<ScaffoldState> rootScaffoldKey = GlobalKey<ScaffoldState>();

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
    return SafeArea(
      child: Scaffold(
        key: rootScaffoldKey,
        drawer: const ProfileDrawer(),
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
                  if (index == 2) {
                    context.read<OfferCubit>().getOffers(100, 1);
                  }
                },
                items: [
                  CustomBottomNavigationBarItem(
                    icon: 'assets/logo_orders.svg',
                    label: 'الطلبات',
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
