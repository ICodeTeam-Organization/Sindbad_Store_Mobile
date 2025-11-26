import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import '../../../../../config/styles/text_style.dart';

class TopInfoOrder extends StatelessWidget {
  const TopInfoOrder({
    super.key,
    required this.orderNumber,
    required this.billNumber,
    required this.color,
  });

  final String orderNumber;
  final String billNumber;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bool isLongOrder = orderNumber.length >= 5;

    return Container(
      // allow the container to be at least 50.h, but let it expand if needed
      constraints: BoxConstraints(minHeight: 50.h),
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.greyHint, width: 0.3),
        ),
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: isLongOrder
          ? Row(
              // space between the two columns
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Use Expanded/Flexible to avoid overflow in tight widths
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('رقم الطلب', style: KTextStyle.textStyle12),
                      SizedBox(height: 4.h),
                      // allow wrapping/ellipsis so it won't overflow vertically beyond container
                      Text(
                        orderNumber,
                        style: KTextStyle.textStyle14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('رقم الفاتورة', style: KTextStyle.textStyle12),
                      SizedBox(height: 4.h),
                      Text(
                        billNumber,
                        style: KTextStyle.textStyle14,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'رقم الطلب $orderNumber',
                    style: KTextStyle.textStyle12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    'رقم الفاتورة $billNumber',
                    style: KTextStyle.textStyle12,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
