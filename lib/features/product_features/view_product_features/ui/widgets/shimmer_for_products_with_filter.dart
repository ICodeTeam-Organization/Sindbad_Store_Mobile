import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/styles/Colors.dart';

class ShimmerForProductsWithFilter extends StatelessWidget {
  const ShimmerForProductsWithFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 6,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 130.h,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(
                  right: 15, top: 26.h, bottom: 26.h, left: 15.w),
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
        });
  }
}

class CustomShimmerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final int borderRadius;
  const CustomShimmerWidget({
    super.key,
    this.borderRadius = 5,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(borderRadius.toDouble())),
      ),
    );
  }
}
