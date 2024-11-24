import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

class MidOrderDetails extends StatelessWidget {
  const MidOrderDetails({
    super.key,
    required this.productMount,
    required this.productPrice,
  });
  final int productMount;
  final double productPrice;
  // final double total;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('العدد : '),
        Text(
          '$productMount',
          style: KTextStyle.textStyle16.copyWith(color: AppColors.primary),
        ),
        SizedBox(
          width: 50.w,
        ),
        Text('السعر : '),
        Text(
          '$productPrice',
          style: KTextStyle.textStyle16.copyWith(color: AppColors.primary),
        ),
        Text('\$'),
        Spacer(),
        Text('الاجمالي'),
        Container(
          padding: EdgeInsets.all(8.0),
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Text(
                '${productMount * productPrice}',
                style:
                    KTextStyle.textStyle16.copyWith(color: AppColors.primary),
              ),
              Text('\$'),
            ],
          ),
        ),
      ],
    );
  }
}
