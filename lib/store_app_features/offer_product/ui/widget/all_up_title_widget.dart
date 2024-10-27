import 'package:flutter/material.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/widget/up_title_widger.dart';

class AllUpTitleWidget extends StatelessWidget {
  const AllUpTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        UpTitleWidget(
          upTital: ' المنتجات: ',
        ),
        UpTitleWidget(
          upTital: 'ملف اكسل',
        ),
      ],
    );
  }
}
