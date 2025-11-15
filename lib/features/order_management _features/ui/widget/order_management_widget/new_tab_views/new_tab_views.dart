import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/widgets/custom_get_main_category_for_view_success_widget.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/widgets/sub_category_card_custom.dart';
import '../../../../../../core/swidgets/new_widgets/sub_custom_tab_bar.dart';
import 'shipping_info_order.dart';
import 'all_info_order.dart';
import 'no_bill_info_order.dart';
import 'no_paid_info_order.dart';

class NewTabViews extends StatelessWidget {
  const NewTabViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SubCustomTabBar(
      length: 4,
      tabs: [
        Tab(
          child: Text(
            'الكل',
            style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
          ),
        ),
        Tab(
          child: Text(
            'بدون فاتورة',
            maxLines: 2,
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ),
        Tab(
          child: Text(
            'لم تسدد',
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ),
        Tab(
          child: Text(
            'للشحن',
            style: Theme.of(context).textTheme.titleMedium!,
          ),
        ),
      ],
      tabViews: [
        //All TabViews
        AllInfoOrder(),
        //NoBill TabViews
        NoBillInfoOrder(),
        //NotPaid TabViews
        NoPaidInfoOrder(),
        //Shipping TabViews
        ShippingInfoOrder(),
      ],
    );
  }
}

/// A combined widget for testing main categories as a horizontal scrollable tab bar.
/// Works with static data.
class TempTabBarForTest extends StatefulWidget {
  const TempTabBarForTest({super.key});

  @override
  State<TempTabBarForTest> createState() => _TempTabBarForTestState();
}

class _TempTabBarForTestState extends State<TempTabBarForTest> {
  int _selectedSubIndex = 0;

  // Static categories for testing
  final List<MainCategoryForViewEntity> allCategory = [
    MainCategoryForViewEntity(mainCategoryId: 0, mainCategoryName: "الكل"),
    MainCategoryForViewEntity(
        mainCategoryId: 1, mainCategoryName: 'بدون فاتورة'),
    MainCategoryForViewEntity(mainCategoryId: 2, mainCategoryName: 'لم تسدد'),
    MainCategoryForViewEntity(mainCategoryId: 3, mainCategoryName: 'للشحن'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: allCategory.length,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, i) {
          final category = allCategory[i];
          return ChipCustom(
            title: category.mainCategoryName,
            isSelected: i == _selectedSubIndex,
            onTap: () {
              // For testing, we just print the selected category
              debugPrint("Selected Category: ${category.mainCategoryName}");
              setState(() {
                _selectedSubIndex = i;
              });
            },
          );
        },
      ),
    );
  }
}
