import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/swidgets/new_widgets/sub_custom_tab_bar.dart';
import '../../../../../../config/styles/text_style.dart';
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
        SizedBox(
          height: 38.h,
          width: 58.82.w,
          child: Tab(
            child: Text(
              'الكل',
              style: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
        ),
        Tab(
          child: Text(
            'بدون فاتورة',
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
