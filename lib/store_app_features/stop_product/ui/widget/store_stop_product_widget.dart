import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';
import 'package:sindbad_management_app/store_app_features/stop_product/ui/widget/custom_text.dart';
import 'package:sindbad_management_app/store_app_features/stop_product/ui/widget/product_input_form.dart';

class StoreStopProductWidget extends StatelessWidget {
  const StoreStopProductWidget(
      {super.key, required this.productNum, required this.productName});
  final String productNum;
  final String productName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          width: 323.w,
          height: 500.h,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.r)),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: ' المنتجات: ',
                  ),
                  CustomText(
                    title: 'ملف اكسل',
                  ),
                ],
              ),
              const ProductInputForm(),
              SizedBox(
                height: 200.h,
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: KCustomPrimaryButtonWidget(
                    buttonName: "تاكيد", onPressed: () {})),
          ],
        )
      ],
    );
  }
}
