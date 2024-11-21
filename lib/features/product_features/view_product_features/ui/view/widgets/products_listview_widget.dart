import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/styles/Colors.dart';
import 'button_custom.dart';
import 'image_card_custom.dart';
import 'text_style_detials.dart';

class ProductsListView extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ProductsListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var product = products[index];
        bool isEven = index % 2 == 0;

        return Container(
          padding: const EdgeInsets.only(top: 26, bottom: 26, left: 7),
          decoration: BoxDecoration(
            color: isEven ? AppColors.background : Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox (غير تفاعلي في البداية)
              Checkbox(
                value: false,
                onChanged: null, // لا يسمح بالتغيير في البداية
                side: BorderSide(
                  color: Colors.red, // حواف المربع
                  width: 1.0,
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
                      children: [
                        TextStyleTitleDataProductBold(title: 'اسم المنتج :  '),
                        TextStyleDataProductGreyDark(
                            dataProduct: product['name']),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        TextStyleTitleDataProductBold(title: 'رقم المنتج :  '),
                        TextStyleDataProductGreyDark(
                            dataProduct: product['id']),
                      ],
                    ),
                    SizedBox(height: 4),
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
