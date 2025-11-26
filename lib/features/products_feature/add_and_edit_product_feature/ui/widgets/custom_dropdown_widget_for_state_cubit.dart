import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';

class CustomDropdownWidgetForStateCubit extends StatelessWidget {
  final String textTitle;
  final String hintText;
  final isRequired;
  const CustomDropdownWidgetForStateCubit({
    super.key,
    required this.textTitle,
    this.isRequired,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget(
      enabled: true,
      textTitle: textTitle,
      isRequired: isRequired,
      hintText: hintText,
      items: [],
      onChanged: (value) => null,
    );
  }
}
