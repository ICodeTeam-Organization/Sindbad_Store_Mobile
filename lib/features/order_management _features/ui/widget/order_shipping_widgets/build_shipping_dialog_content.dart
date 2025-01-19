import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared_widgets/new_widgets/date_text_field.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../manager/shipping/shipping_cubit.dart';
import '../order_details_widget/build_dialog_content.dart';
import '../order_details_widget/build_image_section.dart';
import '../order_details_widget/build_info_row.dart';
import 'another_company_field.dart';
import 'build_info_row_add.dart';
import 'drop_down_widget.dart';

// TextEditingController dateShippingConroller = TextEditingController();
TextEditingController numberShippingConroller = TextEditingController();
TextEditingController mountShippingConroller = TextEditingController();
TextEditingController anotherCompanyConroller = TextEditingController();
TextEditingController anotherCompanyNumberConroller = TextEditingController();

class BuildShippingDialogContent extends StatefulWidget {
  BuildShippingDialogContent({
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
  String anotherCompany = "";

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
              controller: dateConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: widget.secondTitle,
              controller: numberShippingConroller,
            ),
            SizedBox(
              height: 15.h,
            ),
            DropDownWidget(
              onDataChange: (value) {
                setState(() {
                  widget.anotherCompany = value;
                });
              },
            ),
            if (widget.anotherCompany == 'اخرى')
              BuildInfoRow(
                title: 'اسم الشركة',
                controller: anotherCompanyConroller,
              ),
            // AnotherCompanyField(
            //   title: 'اسم الشركة',
            //   controller: anotherCompanyConroller,
            // ),
            if (widget.anotherCompany == 'اخرى')
              BuildInfoRow(
                title: 'رقم التواصل',
                controller: anotherCompanyNumberConroller,
              ),
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
            BlocBuilder<ShippingCubit, ShippingState>(
              builder: (context, state) {
                return StorePrimaryButton(
                  isLoading: state is ShippingLoading,
                  title: 'تاكيد',
                  onTap: widget.onPressedSure,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
