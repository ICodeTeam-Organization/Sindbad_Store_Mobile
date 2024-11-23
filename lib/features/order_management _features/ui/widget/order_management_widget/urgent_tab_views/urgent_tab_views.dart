import 'package:flutter/material.dart';

import '../../../../../../core/shared_widgets/new_widgets/sub_custom_tab_bar.dart';
import '../../../../../../core/styles/text_style.dart';
import '../new_tab_views/shipping_info_order.dart';
import '../new_tab_views/all_info_order.dart';
import '../new_tab_views/no_bill_info_order.dart';
import '../new_tab_views/no_paid_info_order.dart';
import '../new_tab_views/preparing_info_order.dart';

class UrgentTabViews extends StatelessWidget {
  const UrgentTabViews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SubCustomTabBar(
      length: 5,
      tabs: [
        Tab(
          child: Text('الكل',
              style:
                  KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500)),
        ),
        Tab(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Positioned(
                width: 110,
                child: Text('بدون فاتورة',
                    style: KTextStyle.textStyle11
                        .copyWith(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
        Tab(
          child: Text(
            'لم تسدد',
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Text('للتجهيز',
              style:
                  KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500)),
        ),
        Tab(
          child: Text('للشحن',
              style:
                  KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500)),
        ),
      ],
      tabViews: [
        //All TabViews
        AllInfoOrder(),
        //NoBill TabViews
        NoBillInfoOrder(),
        //NotPaid TabViews
        NoPaidInfoOrder(),
        //Preparing TabViews
        PreparingInfoOrder(),
        //Shipping TabViews
        ShippingInfoOrder(),
      ],
    );
  }
}
