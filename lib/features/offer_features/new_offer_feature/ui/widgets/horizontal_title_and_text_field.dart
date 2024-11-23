import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class HorizontalTitleAndTextField extends StatelessWidget {
  final String title;

  const HorizontalTitleAndTextField({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: KTextStyle.textStyle13.copyWith(
            color: AppColors.greyLight,
          ),
        ),
        SizedBox(
          width: 40.h,
        ),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  "assets/calendar.svg",
                ),
              ),
              prefixIconConstraints: BoxConstraints.tight(Size(40, 40)),
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
    );
  }
}
