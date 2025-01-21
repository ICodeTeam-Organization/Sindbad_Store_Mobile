import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';

import '../../../../../core/styles/text_style.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'custom_text_form_widget.dart';

class CustomCardToAllTextFileds extends StatelessWidget {
  const CustomCardToAllTextFileds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductToStoreCubit cubitAddProduct =
        context.read<AddProductToStoreCubit>();
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
              textController: cubitAddProduct
                  .nameProductController, // ================================
              text: 'أسم المنتج',
              height: 65.h,
              width: 400.w,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextFormWidget(
                  textController: cubitAddProduct
                      .priceProductController, // ================================
                  text: 'السعر',
                  width: 130.w,
                  height: 65.h,
                ),
                CustomTextFormWidget(
                  textController: cubitAddProduct
                      .numberProductController, // ================================
                  text: 'رقم المنتج',
                  width: 130.w,
                  height: 65.h,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            CustomTextFormWidget(
              textController: cubitAddProduct
                  .descriptionProductController, // ================================
              text: 'وصف المنتج',
              width: 400.w,
              height: 200.h,
              maxLines: 5, // Allow multiple lines
            ),
          ],
        ),
      ),
    );
  }
}
