import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageLogin extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final String images;
  final num width;
  const ImageLogin(
      {super.key,
      required this.mainAxisAlignment,
      required this.crossAxisAlignment,
      required this.images,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: [
              Container(
                width: width.w,
                child: Image.asset(
                  images,
                ),
              )
            ]));
  }
}
