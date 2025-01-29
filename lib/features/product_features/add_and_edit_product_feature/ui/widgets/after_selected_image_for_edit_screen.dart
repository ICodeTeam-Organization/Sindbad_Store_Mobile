import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AfterSelectedImageForEditScreen extends StatelessWidget {
  final String? initialImageUrl;
  final File? imageFile;
  final int
      boxNumber; // [ 1 = mainImage   ,  2 = subImage 1   ,  3 = subImage 2  ,  4 = subImage 3  ]
  final double containerWidth;
  final double upContainerHeight;
  final void Function() onTapDeleteImage;

  const AfterSelectedImageForEditScreen({
    super.key,
    required this.imageFile,
    required this.containerWidth,
    required this.upContainerHeight,
    required this.boxNumber,
    required this.onTapDeleteImage,
    this.initialImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        initialImageUrl != null
            ? Image.network(
                initialImageUrl!,
                width: containerWidth,
                height: upContainerHeight,
                fit: BoxFit.fill,
                //  an errorBuilder to Image.network to handle image loading failures.
                // if the URL is invalid or the image is not available, the errorBuilder will be called.
                //In the errorBuilder, check the boxNumber.
                // If boxNumber == 1 (main image), display the text "عذرا لا توجد صورة صالحة للعرض".
                // If boxNumber > 1 (sub images), display an appropriate icon indicating no image is available
                errorBuilder: (context, error, stackTrace) {
                  if (boxNumber == 1) {
                    return Center(
                      child: Text(
                        'عذرا لا توجد صورة صالحة للعرض',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 24.w,
                      ),
                    );
                  }
                },
                //////////// THE END OF errorBuilder ////////////
              )
            : Image.file(
                imageFile!,
                width: containerWidth,
                height: upContainerHeight,
                fit: BoxFit.fill,
              ),
        // if (upContainerHeight <= 82)
        boxNumber > 1
            ? // is subImage
            SizedBox()
            // Positioned(
            //     top: 2.0,
            //     left: 0,
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            //       child: Icon(
            //         Icons.edit_square,
            //         color: Colors.white,
            //         size: 15.0,
            //       ),
            //     ),
            //   )
            // else
            : // is mainImage
            Positioned(
                top: 8.0,
                left: 8.0,
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  child: Text(
                    'اضغط لتغيير الصورة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: containerWidth == 100.46 ? 8.0.sp : 12.0.sp,
                    ),
                  ),
                ),
              ),
        boxNumber == 1
            ? SizedBox()
            : Positioned(
                top: boxNumber == 1 ? 8.0 : 2.0, // if == mainImage
                right: boxNumber == 1 ? 8.0 : 1, // if == mainImage
                child: GestureDetector(
                  onTap: onTapDeleteImage, // here fun delete product
                  child: Container(
                    decoration: BoxDecoration(
                        color: boxNumber == 1 ? Colors.black54 : Colors.black38,
                        borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: boxNumber == 1 ? 20.0 : 15.0,
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
