import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get current locale to determine which image to show
    final locale = Localizations.localeOf(context);
    final isEnglish = locale.languageCode == 'en';

    final imagePath = isEnglish
        ? 'assets/images/no_data_image_en.png'
        : 'assets/images/no_data_image.png';

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 135.h,
            width: 135.w,
          ),
        ],
      ),
    );
  }
}
