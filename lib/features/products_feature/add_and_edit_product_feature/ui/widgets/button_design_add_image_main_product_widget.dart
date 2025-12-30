import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class ButtonDesignAddImageMainProduct extends StatelessWidget {
  const ButtonDesignAddImageMainProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: 135.w,
      height: 40.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              l10n.addImage,
              textAlign: TextAlign.center,
              style: KTextStyle.textStyle14.copyWith(color: AppColors.white),
            ),
            SizedBox(width: 8.0.w),
            Icon(
              Icons.add_photo_alternate,
              color: AppColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
