import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class NewOfferWidget extends StatefulWidget {
  const NewOfferWidget({super.key});

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 570,
      width: double.maxFinite,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'اسم العرض ',
                    style: KTextStyle.textStyle13.copyWith(color: AppColors.greyLight,),
                    children: <TextSpan>[
                      TextSpan(
                        text: '*',
                        style: KTextStyle.textStyle13.copyWith(color: AppColors.primary,),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h,),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'أكتب اسم العرض...',
                    hintStyle: KTextStyle.textStyle12.copyWith(color: AppColors.greyLight,),
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
            ),
            SizedBox(height: 40.h,),
            Row(
              children: [
                Text('بداية العرض',style: KTextStyle.textStyle13.copyWith(color: AppColors.greyLight,),),
                SizedBox(width: 40.h,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                        "assets/calendar.svg",
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints.tight(Size(50, 50)),
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
            SizedBox(height: 40.h,),
            Row(
              children: [
                Text('نهاية العرض',style: KTextStyle.textStyle13.copyWith(color: AppColors.greyLight,),),
                SizedBox(width: 40.h,),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                        "assets/calendar.svg",
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints.tight(Size(50, 50)),
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
        ),
      ),
    );
  }
}