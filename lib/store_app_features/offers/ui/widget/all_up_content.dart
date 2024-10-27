import 'package:flutter/material.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/widget/up_content.dart';

class AllUpContent extends StatelessWidget {
  const AllUpContent({
    super.key,
    required this.offerStart,
    required this.offerFinish,
    required this.offerType,
  });

  final String offerStart;
  final String offerFinish;
  final String offerType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UpContent(
          offerStatus: offerStart,
          offerTitle: 'بداية العرض:  ',
        ),
        UpContent(
          offerStatus: offerFinish,
          offerTitle: 'نهاية العرض:  ',
        ),
        UpContent(
          offerStatus: offerType,
          offerTitle: 'نوع العرض: ',
        ),
      ],
    );
  }
}
