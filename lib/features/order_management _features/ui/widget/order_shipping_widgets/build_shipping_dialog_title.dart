import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import 'custom_order_shipping_dialog.dart';

class BuildShippingDialogTitle extends StatelessWidget {
  const BuildShippingDialogTitle({super.key, required this.headTitle});
  final String headTitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              headTitle,
              style: KTextStyle.textStyle14.copyWith(color: AppColors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              dateShippingConroller.clear();
              numberShippingConroller.clear();
              mountShippingConroller.clear();
            },
            icon: SvgPicture.asset(
              "assets/cancle.svg",
              width: 20.w,
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
