import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/horizontal_title_and_text_field.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/required_text.dart';

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
              SizedBox(
                height: 50.h,
                child: TextFormField(
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

class NewOfferInfoTextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final bool isDate;
  final String? initialValue;

  const NewOfferInfoTextFieldWidget({
    super.key,
    required this.title,
    required this.controller,
    required this.isDate,
    this.initialValue,
  });

  @override
  State<NewOfferInfoTextFieldWidget> createState() =>
      _NewOfferInfoTextFieldWidgetState();
}

class _NewOfferInfoTextFieldWidgetState
    extends State<NewOfferInfoTextFieldWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null && widget.controller.text.isEmpty) {
      widget.controller.text = widget.initialValue!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDate == false
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RequiredText(title: widget.title),
              SizedBox(height: 10.h),
              SizedBox(
                height: 50.h,
                child: TextFormField(
                  controller: widget.controller,
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
              ),
            ],
          )
        : NewHorizontalTitleAndTextField(
            title: widget.title,
            info: widget.controller,
            isDate: widget.isDate,
            initialValue: widget.initialValue,
          );
  }
}
