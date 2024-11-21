import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/Colors.dart';
import 'button_custom.dart';
import 'image_card_custom.dart';
import 'text_style_detials.dart';

class ProductsListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final void Function(bool?, int) onChanged; // أضف index
  final List<bool> checkedStates;

  const ProductsListView({
    super.key,
    required this.products,
    required this.onChanged,
    required this.checkedStates,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        bool isEven = index % 2 == 0;

        return Container(
          padding: EdgeInsets.only(top: 26.h, bottom: 26.h, left: 7.w),
          decoration: BoxDecoration(
            color: isEven ? AppColors.background : Colors.white,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Checkbox(
                  value: checkedStates[index],
                  onChanged: (val) => onChanged(val, index),
                  activeColor: AppColors.redDark,
                  checkColor: AppColors.white,
                  side: BorderSide(
                    color: Colors.red,
                    width: 1.0.w,
                  ),
                ),
              ),
              ImageCardCustom(), // افترض أن لديك Card مخصص لعرض الصور
              SizedBox(width: 10),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyleTitleDataProductBold(title: 'اسم المنتج :  '),
                        Expanded(
                          child: TextStyleDataProductGreyDark(
                              dataProduct: product['name']),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        TextStyleTitleDataProductBold(title: 'رقم المنتج :  '),
                        Expanded(
                          child: TextStyleDataProductGreyDark(
                              dataProduct: product['id']),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text('السعر :  ',
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.bold)),
                        Text(
                          '\$${product['price']}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12.sp, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.w),
              // Action Buttons
              Column(
                children: [
                  CustomButton(
                      text: 'تعديل', icon: Icons.edit, onPressed: () {}),
                  SizedBox(height: 5.h),
                  CustomButton(
                      text: 'حذف', icon: Icons.delete, onPressed: () {}),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
