import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../order_details_widget/build_dialog_content.dart';
import '../order_details_widget/build_image_section.dart';
import '../order_details_widget/build_info_row.dart';
import 'build_info_row_add.dart';
import 'drop_down_widget.dart';

// TextEditingController dateShippingConroller = TextEditingController();
TextEditingController numberShippingConroller = TextEditingController();
TextEditingController mountShippingConroller = TextEditingController();

class BuildShippingDialogContent extends StatelessWidget {
  const BuildShippingDialogContent({
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
      height: MediaQuery.sizeOf(context).height * 0.75,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
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
              controller: numberShippingConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            DropDownWidget(),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRowAdd(
              title: 'عدد الطرود',
            ),
            SizedBox(
              height: 5.h,
            ),
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
