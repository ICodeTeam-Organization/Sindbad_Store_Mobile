import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/styles/Colors.dart';

class ImageCardCustom extends StatelessWidget {
  final String imageUrlNetwork;
  const ImageCardCustom({
    super.key,
    required this.imageUrlNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 90.w,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1.5.r, color: AppColors.greyDark)),
      child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: FadeInImage.assetNetwork(
            placeholder: "assets/image_loading.png",
            image: imageUrlNetwork,
            // in case the Image URL is Wrong
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset("assets/image_loading.png");
            },
          )),
    );
  }
}
