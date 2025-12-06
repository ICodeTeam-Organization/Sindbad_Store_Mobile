import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class KCardOrderPriceWidget extends StatefulWidget {
  final int orderAmount;
  final int orderNumber;
  final String orderImage;
  final String Description;
  final String Details;

  const KCardOrderPriceWidget({
    super.key,
    required this.orderAmount,
    required this.orderImage,
    required this.orderNumber,
    required this.Description,
    required this.Details,
  });

  @override
  State<KCardOrderPriceWidget> createState() => _KCardOrderPriceWidgetState();
}

class _KCardOrderPriceWidgetState extends State<KCardOrderPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            height: 90.h,
            width: 360.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25.r),
                  topLeft: Radius.circular(25.r)),
              color: Color.fromRGBO(0, 24, 107, 1),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w, top: 10.h),
                      child: Text("الرقم:",
                          style: KTextStyle.secondaryTitle
                              .copyWith(color: AppColors.greyHint)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w, top: 10.h),
                      child: Text(
                        widget.orderNumber.toString(),
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 100.0.w, top: 10.h),
                      child: Text(
                        "الكمية:",
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.greyHint),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 8.0.w, top: 10.h),
                      child: Text(
                        widget.orderAmount.toString(),
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 20.0.w, top: 1.h),
                      child: Text(
                        "الوصف:",
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.greyHint),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0.w, top: 15.h),
                        child: Text(
                          widget.Description,
                          style: KTextStyle.secondaryTitle
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment:,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 65.0.h, left: 25.w),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(240, 242, 243, 1),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back_outlined,
                          color: AppColors.black))),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5.0.h, left: 25.0.w),
              child: Image.asset(
                widget.orderImage,
                height: 193.h,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 65.0.h),
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 117, 128, 1),
                      borderRadius: BorderRadius.circular(25.r)),
                  child: IconButton(
                      onPressed: () {},
                      icon: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(60),
                          child: Icon(Icons.arrow_back_outlined,
                              color: AppColors.white)))),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: 1.0.h),
          child: Container(
            height: 47.h,
            width: 346.w,
            decoration: BoxDecoration(
                border: Border.all(
              color: Color.fromRGBO(216, 214, 214, 1),
              width: 2.w,
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.0.w,
                  ),
                  child: Text(
                    "التفاصيل:",
                    style: KTextStyle.textStyle12
                        .copyWith(color: AppColors.greyHint),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: 8.0.w,
                    ),
                    child: Text(
                      widget.Description,
                      style: KTextStyle.textStyle12
                          .copyWith(color: AppColors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.0.h),
          child: Container(
            height: 47.h,
            width: 346.w,
            decoration: BoxDecoration(
                border: Border.all(
              color: Color.fromRGBO(216, 214, 214, 1),
              width: 2.w,
            )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    right: 10.0.w,
                  ),
                  child: Text(
                    "الرابط:",
                    style: KTextStyle.textStyle12
                        .copyWith(color: AppColors.greyHint),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 0.0.h, right: 20.0.w, left: 80.w),
                  child: Container(
                      width: 180.w,
                      height: 17.h,
                      color: Colors.white,
                      child: TextField(
                        // controller: number,
                        keyboardType: TextInputType.number,
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
