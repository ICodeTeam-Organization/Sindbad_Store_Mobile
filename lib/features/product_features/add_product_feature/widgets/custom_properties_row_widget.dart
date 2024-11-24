import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/add_product_feature/widgets/custom_simple_text_form_field.dart';

class CustomPropertiesRowWidget extends StatelessWidget {
  final TextEditingController keyTextController;
  final TextEditingController valueTextController;
  final String keyInitialValue;
  final String valueInitialValue;

  const CustomPropertiesRowWidget({
    super.key,
    required this.keyTextController,
    required this.valueTextController,
    required this.keyInitialValue,
    required this.valueInitialValue,
  });

  @override
  Widget build(BuildContext context) {
    // Set initial values to the controllers
    keyTextController.text = keyInitialValue;
    valueTextController.text = valueInitialValue;

    return Row(
      children: [
        CustomSimpleTextFormField(
          textController: keyTextController,
          hintText: 'خاصية',
        ),
        SizedBox(width: 20.w),
        CustomSimpleTextFormField(
          textController: valueTextController,
          hintText: 'قيمة',
        ),
      ],
    );
  }
}