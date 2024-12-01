import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/styles/text_style.dart';

class BottomOrderDetails extends StatelessWidget {
  const BottomOrderDetails({
    super.key,
    required this.barcodeNumber,
  });
  final String barcodeNumber;

  @override
  Widget build(BuildContext context) {
    return BarcodeWidget(
      height: 60.h,
      width: MediaQuery.sizeOf(context).width * 0.9,
      data: barcodeNumber,
      textPadding: 8,
      style: KTextStyle.textStyle14,
      // data: orderNum.toString(), // Data here
      barcode: Barcode.code128(), // Specify the barcode type
    );
  }
}
