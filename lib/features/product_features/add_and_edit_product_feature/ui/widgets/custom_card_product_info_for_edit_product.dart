import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';

class CustomCardProductInfoForEditProduct extends StatefulWidget {
  const CustomCardProductInfoForEditProduct(
      {super.key,
      required TextEditingController priceProductController,
      required TextEditingController descriptionProductController,
      required this.productName,
      required this.productNumber,
      required this.tags,
      required this.shortDescriptionProductController,
      required this.oldPriceController})
      : _priceProductController = priceProductController,
        _descriptionProductController = descriptionProductController;

  final String productName;
  final String productNumber;
  final TextEditingController _priceProductController;
  final TextEditingController _descriptionProductController;
  final List<String> tags;
  final TextEditingController shortDescriptionProductController;
  final TextEditingController oldPriceController;

  @override
  State<CustomCardProductInfoForEditProduct> createState() =>
      _CustomCardProductInfoForEditProductState();
}

class _CustomCardProductInfoForEditProductState
    extends State<CustomCardProductInfoForEditProduct> {
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
              textController: TextEditingController(text: widget.productName),
              text: 'أسم المنتج',
              height: 65.h,
              width: 400.w,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFormWidget(
                  textController: widget._priceProductController,
                  text: 'السعر',
                  width: 130.w,
                  height: 65.h,
                ),
                CustomTextFormWidget(
                  enabled: false,
                  textController:
                      TextEditingController(text: widget.productNumber),
                  text: 'رقم المنتج',
                  width: 130.w,
                  height: 65.h,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(width: 20.w),
            CustomTextFormWidget(
              textController: widget.oldPriceController,
              text: 'السعر السابق',
              isRequired: false,
            ),
            CustomTextFormWidget(
              textController: widget.shortDescriptionProductController,
              text: 'وصف مختصر',
              isRequired: false,
              maxLines: 3,
              width: 400.w,
              height: 130.h,
            ),
            SizedBox(height: 20.h),
            CustomTextFormWidget(
              textController: widget._descriptionProductController,
              text: 'وصف المنتج',
              width: 400.w,
              height: 200.h,
              maxLines: 5,
            ),
            CustomTextFormWidget(
              textController: null,
              onFieldSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    widget.tags.add(value);
                  });
                }
              },
              text: 'صفات المنتج',
              width: 400.w,
              height: 65.h,
              keyboardType: TextInputType.number,
              isRequired: false,
            ),
            SizedBox(height: 20.h),
            Wrap(
              spacing: 8.0, // Spacing between tags
              runSpacing: 4.0, // Spacing between lines
              children: [
                for (var tag in widget.tags)
                  Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        widget.tags.remove(tag);
                      });
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
