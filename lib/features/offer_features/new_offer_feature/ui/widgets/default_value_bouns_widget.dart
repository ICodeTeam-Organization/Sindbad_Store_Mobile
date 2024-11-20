
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class DefaultValueBounsWidget extends StatelessWidget {
  const DefaultValueBounsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('القيمة الأفتراضية ',style: KTextStyle.textStyle14.copyWith(color: AppColors.blackLight,),),
        SizedBox(height: 20.h,),
            Row(
              children: [
                Text('كمية شراء المنتج المطلوبة للحصول على العرض ',style: KTextStyle.textStyle10.copyWith(color: AppColors.blackDark,),),
                SizedBox(width: 40.h,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
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
                ),
              ],
            ),
            Row(
              children: [
                Text('الكمية التي سيحصل عليها العميل من نفس المنتج ',style: KTextStyle.textStyle10.copyWith(color: AppColors.blackDark,),),
                SizedBox(width: 40.h,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
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
                ),
              ],
            ),
      ],
    );
  }
}