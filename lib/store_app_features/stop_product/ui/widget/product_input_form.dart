import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/store_app_features/stop_product/ui/widget/custom_input_widget.dart';
import 'package:sindbad_management_app/store_app_features/stop_product/ui/widget/custom_text.dart';

class ProductInputForm extends StatelessWidget {
  const ProductInputForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      decoration: BoxDecoration(
          color: AppColors.scaffColor,
          borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        children: [
          Row(
            children: [
              const CustomText(
                title: 'رقم المنتج:  ',
              ),

              // ادخال رقم المنتج
              CustomInputWidget(),
            ],
          ),
          Row(
            children: [
              const CustomText(
                title: 'اسم المنتج:  ',
              ),
              // ادخال اسم المنتج
              CustomInputWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
