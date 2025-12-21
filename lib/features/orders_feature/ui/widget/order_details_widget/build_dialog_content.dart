import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/function/image_picker_function.dart';
import '../../../../../core/widgets/date_text_field.dart';
import '../../../../../core/widgets/store_primary_button.dart';
import 'build_image_section.dart';
import 'build_info_row.dart';
import 'radio_widget.dart';

class BuildDialogContent extends StatefulWidget {
  const BuildDialogContent({
    super.key,
    this.isLoading = false,
    required this.onPressedSure,
    required this.dateController,
    required this.numberController,
    required this.mountController,
  });
  final bool? isLoading;
  final GestureTapCallback onPressedSure;
  //
  final TextEditingController dateController;
  final TextEditingController numberController;
  final TextEditingController mountController;

  @override
  State<BuildDialogContent> createState() => _BuildDialogContentState();
}

class _BuildDialogContentState extends State<BuildDialogContent> {
  String? _errorMessage = "";
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
              title: "تاريخ الفاتورة",
              controller: widget.dateController,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: "رقم الفاتورة",
              controller: widget.numberController,
            ),
            SizedBox(
              height: 15.h,
            ),
            BuildInfoRow(
              title: "قيمة الفاتورة",
              controller: widget.mountController,
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
            // StorePrimaryButton(
            //   title: 'تاكيد',
            //   onTap: onPressedSure,
            //   isLoading: isLoading,
            // ),
            StorePrimaryButton(
              title: 'تاكيد',
              onTap: () async {
                try {
                  // Validate the mountController text

                  // Try to parse the mountController text to a double
                  double? invoiceAmount;
                  try {
                    if (images == null) {
                      invoiceAmount = double.parse(widget.mountController.text);
                    }
                  } catch (e) {
                    setState(() {
                      _errorMessage =
                          'قيمة الفاتورة غير صالحة. يرجى إدخال رقم صحيح.';
                    });
                    return;
                  }

                  // Ensure images are not null
                  if (images == null) {
                    setState(() {
                      _errorMessage = 'يرجى تحميل صورة الفاتورة.';
                    });
                    return;
                  }

                  // Ensure pay is not null
                  if (pay == null) {
                    setState(() {
                      _errorMessage = 'يرجى تحديد نوع الفاتورة.';
                    });
                    return;
                  }

                  // Call the onPressedSure callback
                  widget.onPressedSure();
                } catch (e) {
                  setState(() {
                    _errorMessage = 'حدث خطأ ما. حاول مرة أخرى.';
                  });
                }
              },
              isLoading: widget.isLoading,
            ),
// if (_errorMessage != null)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
