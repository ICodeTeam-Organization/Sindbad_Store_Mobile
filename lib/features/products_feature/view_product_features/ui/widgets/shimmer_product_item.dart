import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/shimmer_for_products_with_filter.dart';

class ShimmerProductItem extends StatelessWidget {
  const ShimmerProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130.h,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding:
            EdgeInsets.only(right: 15, top: 26.h, bottom: 26.h, left: 15.w),
        child: Row(
          children: [
            CustomShimmerWidget(height: 17.w, width: 17.w),
            SizedBox(width: 13.w),
            CustomShimmerWidget(height: 75.w, width: 75.w),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomShimmerWidget(height: 12.h, width: null),
                  CustomShimmerWidget(height: 12.h, width: 70.w),
                  CustomShimmerWidget(height: 12.h, width: 40.w),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomShimmerWidget(height: 30.h, width: 70.w),
                SizedBox(height: 5.h),
                CustomShimmerWidget(height: 30.h, width: 70.w),
              ],
            )
          ],
        ),
      ),
    );
  }
}
