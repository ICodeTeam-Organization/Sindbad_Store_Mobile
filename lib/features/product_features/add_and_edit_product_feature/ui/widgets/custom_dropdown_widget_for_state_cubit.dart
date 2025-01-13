import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';

class CustomDropdownWidgetForStateCubit extends StatelessWidget {
  final String textTitle;
  final String hintText;
  const CustomDropdownWidgetForStateCubit({
    super.key,
    required this.textTitle,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget(
      enabled: false,
      textTitle: textTitle,
      hintText: hintText,
      items: [],
      onChanged: (value) => null,
    );
  }
}
