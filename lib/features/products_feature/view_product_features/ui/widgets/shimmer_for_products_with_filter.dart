import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/shimmer_product_item.dart';
import '../../../../../config/styles/Colors.dart';

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
          return const ShimmerProductItem();
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
