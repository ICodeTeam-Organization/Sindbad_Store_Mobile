import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/horizontal_title_and_text_field.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/required_text.dart';

class OfferInfoTextFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isDate;

  const OfferInfoTextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.isDate,
  });

  @override
  Widget build(BuildContext context) {
    return isDate == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequiredText(title: title),
              SizedBox(height: 10.h),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'أكتب هنا...',
                  hintStyle: KTextStyle.textStyle12.copyWith(
                    color: AppColors.greyLight,
                  ),
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
          )
        : HorizontalTitleAndTextField(
            title: title,
            info: controller,
            isDate: isDate,
          );
  }
}
