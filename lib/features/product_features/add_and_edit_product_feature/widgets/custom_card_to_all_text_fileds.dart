import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/text_style.dart';
import '../ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'custom_text_form_widget.dart';

class CustomCardToAllTextFileds extends StatelessWidget {
  const CustomCardToAllTextFileds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddProductToStoreCubit cubitAddProduct =
        context.read<AddProductToStoreCubit>();
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.r),
      ),
      color: Colors.white,
      child: Container(
        width: 363.0.w,
        height: 434.0.h,
        margin: EdgeInsets.only(
          bottom: 20.0.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  container Title
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 16.0.h, top: 8.h, right: 20.0.w),
                child: Text(
                  "معلومات المنتج",
                  style: KTextStyle.textStyle16
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            CustomTextFormWidget(
              textController: cubitAddProduct
                  .nameProductController, // ================================
              text: 'أسم المنتج',
              width: 334.0.w,
              height: 65.h,
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomTextFormWidget(
                    textController: cubitAddProduct
                        .priceProductController, // ================================
                    text: 'السعر',
                    width: 147.0.w,
                    height: 65.h,
                  ),
                  SizedBox(
                    width: 36.0.w,
                  ),
                  CustomTextFormWidget(
                    textController: cubitAddProduct
                        .numberProductController, // ================================
                    text: 'رقم المنتج',
                    width: 147.0.w,
                    height: 65.h,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            CustomTextFormWidget(
              textController: cubitAddProduct
                  .descriptionProductController, // ================================
              text: 'وصف المنتج',
              // labelText: 'أدخل وصف المنتج',
              width: 334.0.w,
              height: 200.0.h,
              // initialValue: '',
              maxLines: 5, // Allow multiple lines
            ),
          ],
        ),
      ),
    );
  }
}
