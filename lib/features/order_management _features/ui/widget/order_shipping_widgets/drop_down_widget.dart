import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:sindbad_management_app/core/styles/Colors.dart';

const List<String> _list = [
  'الافضل',
  'البراق',
  'السريع',
  'توصيل',
];
// SingleSelectController dropDownController = SingleSelectController(String value);

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CustomDropdown(
        // controller: dropDownController ,
        items: _list,
        initialItem: _list[0],
        onChanged: (value) {
          log('changing value to: $value');
        },
        decoration: CustomDropdownDecoration(
            closedFillColor: Colors.transparent,
            closedBorder: Border.all(color: AppColors.grey)),
      ),
    );
  }
}
