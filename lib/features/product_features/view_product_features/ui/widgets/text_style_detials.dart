import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/Colors.dart';

class TextStyleTitleDataProductBold extends StatelessWidget {
  const TextStyleTitleDataProductBold({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class TextStyleDataProductGreyDark extends StatelessWidget {
  const TextStyleDataProductGreyDark({
    super.key,
    required this.dataProduct,
  });

  final String dataProduct;

  @override
  Widget build(BuildContext context) {
    return Text(
      dataProduct,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: AppColors.greyDark,
        fontSize: 12.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
