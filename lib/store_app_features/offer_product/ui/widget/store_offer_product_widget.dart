import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/q_text_title_list_view_widget.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class StoreOfferProductWidget extends StatelessWidget {
  const StoreOfferProductWidget(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    " المنتجات: ",
                    style: KTextStyle.secondaryTitle
                        .copyWith(color: AppColors.greyHint),
                  ),
                  Text(
                    "ملف اكسل",
                    style: KTextStyle.secondaryTitle
                        .copyWith(color: AppColors.greyHint),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                decoration: BoxDecoration(
                    color: AppColors.scaffColor,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "رقم المنتج:   ",
                          style: KTextStyle.secondaryTitle
                              .copyWith(color: AppColors.greyHint),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          width: 100.w,
                          height: 25.h,
                          color: AppColors.primaryColor,
                          child: Text(productNum),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const TextTitleListViewWidget(
                            textName: "اسم المنتج:  "),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 4.h),
                          width: 200.w,
                          height: 25.h,
                          color: AppColors.primaryColor,
                          child: Text(productName),
                        )
                      ],
                    ),
                  ],
                ),
              ),
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
