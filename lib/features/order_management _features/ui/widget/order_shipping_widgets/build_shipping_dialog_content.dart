import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/custom_order_print_dialog.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../order_details_widget/build_image_section.dart';
import 'build_shipping_info_row.dart';
import 'custom_order_shipping_dialog.dart';

// TextEditingController dateShippingConroller = TextEditingController();
// TextEditingController numberShippingConroller = TextEditingController();
// TextEditingController mountShippingConroller = TextEditingController();

class BuildShippingDialogContent extends StatelessWidget {
  const BuildShippingDialogContent(
      {super.key,
      required this.firstTitle,
      required this.secondTitle,
      required this.thierdTitle,
      required this.onPressedSure,
      required this.copy});

  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  final int copy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.7,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BuildShippingInfoRow(
              title: firstTitle,
              isDate: true,
              controller: dateShippingConroller,
            ),
            BuildShippingInfoRow(
              title: secondTitle,
              isDate: false,
              controller: numberShippingConroller,
            ),
            BuildShippingInfoRow(
              title: thierdTitle,
              isDate: false,
              controller: mountShippingConroller,
            ),
            BuildInfoRowAdd(
              copy: copy,
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
