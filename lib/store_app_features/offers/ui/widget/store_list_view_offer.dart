import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';

class StoreListViewOffer extends StatelessWidget {
  const StoreListViewOffer(
      {super.key,
      required this.offerStart,
      required this.offerFinish,
      required this.categorys,
      required this.offerType,
      required this.category,
      required this.discountRate,
      required this.bouns});
  final String offerStart;
  final String offerFinish;
  final String offerType;
  final String categorys;
  final String category;
  final String discountRate;
  final String bouns;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370.w,
      height: 530.h,
      child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, i) {
            return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                ),
                margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.r),
                    color: AppColors.primaryColor,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-1, 1),
                          blurRadius: 1)
                    ]),
                width: 370.w,
                height: 500.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100.h,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 5.w),
                            child: Row(
                              children: [
                                Text(
                                  "بداية العرض:  ",
                                  style: KTextStyle.textStyle12
                                      .copyWith(color: AppColors.greyHint),
                                ),
                                Text(
                                  offerStart,
                                  style: KTextStyle.secondaryTitle,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 5.w),
                            child: Row(
                              children: [
                                Text("نهاية العرض:  ",
                                    style: KTextStyle.textStyle12
                                        .copyWith(color: AppColors.greyHint)),
                                Text(offerFinish,
                                    style: KTextStyle.secondaryTitle),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 5.h, horizontal: 5.w),
                            child: Row(
                              children: [
                                Text("نوع العرض:  ",
                                    style: KTextStyle.textStyle12
                                        .copyWith(color: AppColors.greyHint)),
                                Text(offerType,
                                    style: KTextStyle.secondaryTitle),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(" الاصناف: ",
                                  style: KTextStyle.textStyle12
                                      .copyWith(color: AppColors.greyHint)),
                              Text(categorys, style: KTextStyle.secondaryTitle),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 85.h,
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      decoration:
                          const BoxDecoration(color: AppColors.scaffColor),
                      alignment: Alignment.topRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("الصنف:  ",
                                  style: KTextStyle.secondaryTitle
                                      .copyWith(fontWeight: FontWeight.w500)),
                              Text(category, style: KTextStyle.secondaryTitle)
                            ],
                          ),
                          Row(
                            children: [
                              Text("نسبة الخصم:  ",
                                  style: KTextStyle.secondaryTitle
                                      .copyWith(fontWeight: FontWeight.w500)),
                              Text(discountRate)
                            ],
                          ),
                          Row(
                            children: [
                              Text("البونص:  ",
                                  style: KTextStyle.secondaryTitle
                                      .copyWith(fontWeight: FontWeight.w500)),
                              Text(bouns, style: KTextStyle.secondaryTitle)
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 250.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        KCustomPrimaryButtonWidget(
                            buttonName: "تنفيذ", onPressed: () {})
                      ],
                    )
                  ],
                ));
          }),
    );
  }
}
