import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/custom_order_print_dialog.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../order_details_widget/build_image_section.dart';
import '../order_details_widget/build_info_row.dart';
import 'build_info_row_add.dart';
import 'custom_order_shipping_dialog.dart';
import 'drop_down_widget.dart';

class BuildShippingDialogContent extends StatelessWidget {
  const BuildShippingDialogContent(
      {super.key,
      required this.firstTitle,
      required this.secondTitle,
      required this.thierdTitle,
      required this.onPressedSure,
      required this.parcels});

  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  final int parcels;

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
            BuildInfoRow(
              title: firstTitle,
              isDate: true,
              controller: dateShippingConroller,
            ),
            BuildInfoRow(
              title: secondTitle,
              isDate: false,
              controller: numberShippingConroller,
            ),
            DropDownWidget(),
            BuildInfoRowAdd(
              parcels: parcels,
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
