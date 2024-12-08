import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import 'build_image_section.dart';
import 'build_info_row.dart';
import 'radio_widget.dart';

TextEditingController dateConroller = TextEditingController();
TextEditingController numberConroller = TextEditingController();
TextEditingController mountConroller = TextEditingController();

class BuildDialogContent extends StatelessWidget {
  const BuildDialogContent({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
  });

  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.7,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildInfoRow(
              title: firstTitle,
              isDate: true,
              controller: dateConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: secondTitle,
              isDate: false,
              controller: numberConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: thierdTitle,
              isDate: false,
              controller: mountConroller,
            ),
            /////////////////////////////////
            ///show radio
            SizedBox(
              height: 15.h,
            ),
            RadioWidget(),
            BuildImageSection(),
            SizedBox(
              height: 20.h,
            ),
            StorePrimaryButton(
              title: 'تاكيد',
              onTap: onPressedSure,
            ),
          ],
        ),
      ),
    );
  }
}
