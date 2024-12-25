import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForMainCategoryForView extends StatelessWidget {
  const ShimmerForMainCategoryForView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.zero,
          itemCount: 6, // عدد العناصر التي سيتم عرضها
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
              width: index == 0 ? 70.0.w : 150.0.w, // العرض لكل عنصر
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
            );
          },
        ),
      ),
    );
  }
}
