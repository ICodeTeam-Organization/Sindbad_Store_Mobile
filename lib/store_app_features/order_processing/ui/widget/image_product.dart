import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageProduct extends StatelessWidget {
  const ImageProduct({
    super.key,
    required this.imageProduct,
  });

  final String imageProduct;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: .88,
      child: Image.asset(
        imageProduct,
        width: MediaQuery.of(context).size.width * .36,
        height: 140.h,
        fit: BoxFit.fill,
      ),
    );
  }
}
