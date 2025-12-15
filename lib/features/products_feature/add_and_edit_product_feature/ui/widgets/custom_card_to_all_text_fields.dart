import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'custom_text_form_widget.dart';

class CustomCardToAllTextFields extends StatefulWidget {
  // final AddProductToStoreCubit cubitAddProduct;
  final TextEditingController shortDescriptionController;
  final TextEditingController oldPriceController;
  final List<String> tags;
  const CustomCardToAllTextFields({
    super.key,
    // required this.cubitAddProduct,
    required this.shortDescriptionController,
    required this.oldPriceController,
    required this.tags,
  });

  @override
  State<CustomCardToAllTextFields> createState() =>
      _CustomCardToAllTextFieldsState();
}

class _CustomCardToAllTextFieldsState extends State<CustomCardToAllTextFields> {
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
            //  container Title
            SectionTitleWidget(title: 'معلومات المنتج'),
            SizedBox(height: 20.h),
            CustomTextFormWidget(
              textController:
                  context.read<AddProductToStoreCubit>().nameProductController,
              text: 'أسم المنتج',
              height: 65.h,
              width: 400.w,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFormWidget(
                  keyboardType: TextInputType.number,
                  textController: context
                      .read<AddProductToStoreCubit>()
                      .priceProductController,
                  text: 'السعر',
                  width: 130.w,
                  height: 65.h,
                ),
                SizedBox(width: 20.w),
                CustomTextFormWidget(
                  keyboardType: TextInputType.number,
                  textController: context
                      .read<AddProductToStoreCubit>()
                      .numberProductController,
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
            SizedBox(height: 20.h),
            CustomTextFormWidget(
              textController: widget.shortDescriptionController,
              text: 'وصف مختصر',
              isRequired: false,
              maxLines: 3,
              width: 400.w,
              height: 130.h,
            ),
            // CustomTextFormWidget(
            //   textController:
            //       widget.cubitAddProduct.descriptionProductController,
            //   text: 'وصف المنتج',
            //   width: 400.w,
            //   height: 200.h,
            //   maxLines: 5, // Allow multiple lines
            //   keyboardType: TextInputType.multiline,
            //   isRequired: false,
            // ),

            // CustomTextFormWidget(
            //   textController: null,
            //   onFieldSubmitted: (value) {
            //     if (value.isNotEmpty) {
            //       setState(() {
            //         widget.tags.add(value);
            //       });
            //     }
            //   },
            //   text: 'صفات المنتج',
            //   width: 400.w,
            //   height: 65.h,
            //   keyboardType: TextInputType.number,
            //   isRequired: false,
            // ),
            // SizedBox(height: 20.h),
            // Wrap(
            //   spacing: 8.0, // Spacing between tags
            //   runSpacing: 4.0, // Spacing between lines
            //   children: widget.tags.map((tag) {
            //     return Chip(
            //       label: Text(tag),
            //       onDeleted: () {
            //         setState(() {
            //           widget.tags.remove(tag);
            //         });
            //       },
            //     );
            //   }).toList(),
            // ),
          ],
        ),
      ),
    );
  }
}
