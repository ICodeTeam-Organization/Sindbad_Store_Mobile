import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';

class CustomCardProductInfoForEditProduct extends StatelessWidget {
  const CustomCardProductInfoForEditProduct({
    super.key,
    required TextEditingController priceProductController,
    required TextEditingController descriptionProductController,
    required this.productName,
    required this.productNumber,
  })  : _priceProductController = priceProductController,
        _descriptionProductController = descriptionProductController;

  final String productName;
  final String productNumber;
  final TextEditingController _priceProductController;
  final TextEditingController _descriptionProductController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitleWidget(title: 'معلومات المنتج'),
            SizedBox(height: 20.h),
            CustomTextFormWidget(
              enabled: false,
              textController: TextEditingController(text: productName),
              text: 'أسم المنتج',
              height: 65.h,
              width: 400.w,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFormWidget(
                  textController: _priceProductController,
                  text: 'السعر',
                  width: 130.w,
                  height: 65.h,
                ),
                CustomTextFormWidget(
                  enabled: false,
                  textController: TextEditingController(text: productNumber),
                  text: 'رقم المنتج',
                  width: 130.w,
                  height: 65.h,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomTextFormWidget(
              textController: _descriptionProductController,
              text: 'وصف المنتج',
              width: 400.w,
              height: 200.h,
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
