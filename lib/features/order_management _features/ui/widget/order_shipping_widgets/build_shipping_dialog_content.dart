import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/date_text_field.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../order_details_widget/build_image_section.dart';
import '../order_details_widget/build_info_row.dart';
import 'build_info_row_add.dart';
import 'drop_down_widget.dart';

class BuildShippingDialogContent extends StatefulWidget {
  const BuildShippingDialogContent({
    super.key,
    this.isLoading = false,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
    required this.dateController,
    required this.numberShippingController,
    required this.mountShippingController,
    required this.anotherCompanyController,
    required this.anotherCompanyNumberController,
  });
  final bool? isLoading;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  //
  final TextEditingController dateController;

  final TextEditingController numberShippingController;

  final TextEditingController mountShippingController;

  final TextEditingController anotherCompanyController;

  final TextEditingController anotherCompanyNumberController;

  @override
  State<BuildShippingDialogContent> createState() =>
      _BuildShippingDialogContentState();
}

class _BuildShippingDialogContentState
    extends State<BuildShippingDialogContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.8,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DateTextField(
              title: widget.firstTitle,
              controller: widget.dateController,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: widget.secondTitle,
              controller: widget.numberShippingController,
            ),
            SizedBox(
              height: 15.h,
            ),
            DropDownWidget(
              onDataChange: (value) {
                setState(() {
                  companyName = value;
                });
              },
            ),
            companyName == "اخرى"
                ? buildAnotherCompany(companyName ?? '')
                : Center(),
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
              isLoading: widget.isLoading,
              title: 'تاكيد',
              onTap: widget.onPressedSure,
            ),
          ],
        ),
      ),
    );
  }

  Column buildAnotherCompany(String companyName) {
    return Column(
      children: [
        BuildInfoRow(
          keyboardType: TextInputType.text,
          title: 'اسم الشركة',
          controller: widget.anotherCompanyController,
        ),
        BuildInfoRow(
          title: 'رقم التواصل',
          controller: widget.anotherCompanyNumberController,
        ),
      ],
    );
  }
}
