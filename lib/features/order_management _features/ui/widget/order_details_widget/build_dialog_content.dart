import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/date_text_field.dart';
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
    this.isLoading = false,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
  });
  final bool? isLoading;
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
            DateTextField(
              title: firstTitle,
              controller: dateConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: secondTitle,
              controller: numberConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: thierdTitle,
              controller: mountConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            //!show radio
            RadioWidget(),
            BuildImageSection(),
            SizedBox(
              height: 20.h,
            ),
            StorePrimaryButton(
              title: 'تاكيد',
              onTap: onPressedSure,
              isLoading: isLoading,
            ),
          ],
        ),
      ),
    );
  }
}
