import 'package:flutter/material.dart';
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
        Tab(
          child: Text(
            'الكل',
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Tab(
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Positioned(
                width: 110,
                child: Text(
                  'بدون فاتورة',
                  style: KTextStyle.textStyle14
                      .copyWith(fontWeight: FontWeight.w500),
                ),
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
          child: Text(
            'للشحن',
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
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
