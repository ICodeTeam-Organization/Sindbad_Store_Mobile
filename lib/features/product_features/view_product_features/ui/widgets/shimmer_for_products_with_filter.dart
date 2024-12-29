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
          bool isEven = index % 2 == 0;
          return Shimmer.fromColors(
            baseColor: isEven ? Colors.grey[100]! : Colors.grey[300]!,
            highlightColor: isEven ? Colors.grey[300]! : Colors.grey[100]!,
            child: Container(
              color: isEven ? AppColors.background : Colors.white,
              height: 130.h,
              width: MediaQuery.of(context).size.width,
            ),
          );
        });
  }
}
