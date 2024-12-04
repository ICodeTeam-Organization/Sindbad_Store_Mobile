import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../ui/manger/cubit/add_product_to_store_cubit.dart';

class AfterSelectedImage extends StatelessWidget {
  const AfterSelectedImage({
    super.key,
    required this.imageFile,
    required this.containerWidth,
    required this.upContainerHeight,
    required this.boxNumber,
  });

  final File imageFile;
  final int boxNumber;
  final double containerWidth;
  final double upContainerHeight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.file(
          imageFile,
          width: containerWidth,
          height: upContainerHeight,
          fit: BoxFit.cover,
        ),
        if (upContainerHeight <= 82)
          Positioned(
            top: 2.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Icon(
                Icons.edit_square,
                color: Colors.white,
                size: 15.0,
              ),
            ),
          )
        else
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
        Positioned(
          top: upContainerHeight > 82 ? 8.0 : 2.0,
          right: upContainerHeight > 82 ? 8.0 : 1,
          child: GestureDetector(
            onTap: () => context
                .read<AddProductToStoreCubit>()
                .deleteImageByNumBox(numBox: boxNumber),
            child: Container(
              color: upContainerHeight > 82 ? Colors.black54 : null,
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: upContainerHeight <= 82 ? 15.0 : 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
