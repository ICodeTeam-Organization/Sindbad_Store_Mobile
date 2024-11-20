
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class DefaultValueDiscountWidget extends StatelessWidget {
  const DefaultValueDiscountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('القيمة الأفتراضية ',style: KTextStyle.textStyle14.copyWith(color: AppColors.blackLight,),),
        SizedBox(height: 20.h,),
        Text('نسبة الخصم',style: KTextStyle.textStyle13.copyWith(color: AppColors.greyLight,),),
        SizedBox(height: 10.h,),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(Icons.percent,color: AppColors.greyLight,size: 15,)
            ),
            hintText: '10',
            hintStyle: KTextStyle.textStyle18.copyWith(color: AppColors.greyDark,),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.greyBorder,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
      ],
    );
  }
}