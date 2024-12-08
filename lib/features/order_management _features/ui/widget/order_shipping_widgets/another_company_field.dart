import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/drop_down_widget.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

// ignore: must_be_immutable
class AnotherCompanyField extends StatelessWidget {
  AnotherCompanyField(
      {super.key, required this.title, required this.controller});
  final String title;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? validCompany = companyName;
    GlobalKey<FormState> formstate = GlobalKey<FormState>();
    send() {
      var formData = formstate.currentState;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w500),
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          SizedBox(
            width: 200.w,
            height: 48.h,
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formstate,
              child: TextFormField(
                validator: (validCompany) {
                  if (companyName != "اخرى") {
                    return 'لا يمكن ادخال معومات حول هذه الشركة ';
                  }
                },
                maxLines: 10,
                keyboardType: TextInputType.number,
                controller: controller,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey,
                      width: 1.w,
                    ),
                  ),
                ),
                style: KTextStyle.textStyle12
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
