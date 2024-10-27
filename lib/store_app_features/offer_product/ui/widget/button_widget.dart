import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.onPressed,
  });
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: KCustomPrimaryButtonWidget(
                buttonName: "تاكيد", onPressed: onPressed)),
      ],
    );
  }
}
