import 'package:flutter/material.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class RequiredText extends StatelessWidget {
  final String title;
  const RequiredText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: KTextStyle.textStyle13.copyWith(
          color: AppColors.greyLight,
        ),
        children: <TextSpan>[
          TextSpan(
            text: ' *',
            style: KTextStyle.textStyle13.copyWith(
              color: AppColors.primary,
            ),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}
