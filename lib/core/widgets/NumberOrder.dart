import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/core/widgets/DataOrder.dart';

class KNumberOrderWidget extends StatefulWidget {
  final bool isShow;

  const KNumberOrderWidget({super.key, required this.isShow});
  @override
  State<KNumberOrderWidget> createState() => _KNumberOrderWidgetState();
}

TextEditingController OrderNumber = TextEditingController();
TextEditingController OrderNumber1 = TextEditingController();

class _KNumberOrderWidgetState extends State<KNumberOrderWidget> {
  // String NumberParcels;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 38.0.h, right: 50.w),
                    child: Text(
                      "رقم الطلب:",
                      style: KTextStyle.textStyle12
                          .copyWith(color: AppColors.greyHint),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 40.0.h, right: 20.0.w, left: 80.w),
                    child: Container(
                        width: 165.w,
                        height: 23.h,
                        color: Colors.white,
                        child: TextField(
                          controller: OrderNumber,
                          keyboardType: TextInputType.number,
                        )),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              if (widget.isShow != true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 7.0.h, right: 45.w),
                      child: Text(
                        "كود التسليم:",
                        style: KTextStyle.textStyle12
                            .copyWith(color: AppColors.greyHint),
                      ),
                    ),
                    // Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 10.0.h, right: 20.0.w, left: 80.w),
                      child: Container(
                          width: 165.w,
                          height: 23.h,
                          color: Colors.white,
                          child: TextField(
                            controller: OrderNumber1,
                            keyboardType: TextInputType.number,
                          )),
                    ),
                  ],
                ),
            ],
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.all(8.0.h.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 18.0.w),
                  child: Container(
                    height: 38.h,
                    width: 124.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.greenDark),
                    ),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "استلام",
                          style:
                              KTextStyle.tabs.copyWith(color: AppColors.black),
                        ),
                        onPressed: () {
                          setState(() {
                            OrderNumber.text;
                          });
                        }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 50.0.w),
                  child: Container(
                    height: 38.h,
                    width: 124.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.greenDark),
                    ),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          "قراءة باركود",
                          style:
                              KTextStyle.tabs.copyWith(color: AppColors.black),
                        ),
                        onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
          KDataOrderWidget(
            OrderNumber: OrderNumber.text,
          ),
        ],
      ),
    );
  }
}
