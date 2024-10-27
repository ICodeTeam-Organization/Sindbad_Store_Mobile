import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class ProductName extends StatelessWidget {
  const ProductName({
    super.key,
    required this.productName,
  });

  final String productName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .6,
      height: 35.h,
      child: Text(
        productName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: KTextStyle.secondaryTitle,
      ),
    );
  }
}
