import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

class MidOrderDetails extends StatelessWidget {
  const MidOrderDetails({
    super.key,
    required this.productMount,
    required this.productPrice,
    required this.total,
  });
  final int productMount;
  final double productPrice;
  final double total;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('العدد:'),
        Text(
          '$productMount',
          style: KTextStyle.textStyle16.copyWith(color: AppColors.primary),
        ),
        Spacer(),
        // SizedBox(
        //   width: 20.w,
        // ),
        Text('السعر:'),
        Text(
          '$productPrice',
          style: KTextStyle.textStyle16.copyWith(color: AppColors.primary),
        ),
        Text('\$'),
        Spacer(),
        Text('الاجمالي'),
        Container(
          // width: MediaQuery.sizeOf(context).width * 0.3,
          padding: EdgeInsets.all(4.0),
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            children: [
              Text(
                '$total',
                overflow: TextOverflow.ellipsis,
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
