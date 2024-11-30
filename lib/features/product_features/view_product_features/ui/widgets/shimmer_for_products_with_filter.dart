import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerForProductsWithFilter extends StatelessWidget {
  const ShimmerForProductsWithFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder: (context, index) {
              return ListTile(
                title: Container(
                  color: Colors.white,
                  height: 130.h,
                  width: MediaQuery.of(context).size.width,
                ),
              );
            }));
  }
}
