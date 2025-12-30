import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';

class KDataOrderWidget extends StatefulWidget {
  String NumberParcels;
  String Phone;
  String Costmor;
  String OrderNumber;
  String TotalNumber;

  KDataOrderWidget({
    super.key,
    required this.OrderNumber,
    this.Phone = "",
    this.Costmor = "",
    this.NumberParcels = "",
    this.TotalNumber = "",
  });

  @override
  State<KDataOrderWidget> createState() => _KDataOrderWidgetState();
}

class _KDataOrderWidgetState extends State<KDataOrderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 290.h,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
      child: Padding(
        padding:
            EdgeInsets.only(left: 8.0.w, top: 8.h, bottom: 8.h, right: 22.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "رقم الطلب:",
                  style: KTextStyle.textStyle12
                      .copyWith(color: AppColors.greyHint),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  widget.OrderNumber,
                  style:
                      KTextStyle.textStyle12.copyWith(color: AppColors.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "التلفون :    ",
                  style: KTextStyle.textStyle12
                      .copyWith(color: AppColors.greyHint),
                ),
                Text(
                  widget.Phone.toString(),
                  style:
                      KTextStyle.textStyle12.copyWith(color: AppColors.black),
                ),
                SizedBox(
                  width: 20.w,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "العميل :     ",
                  style: KTextStyle.textStyle12
                      .copyWith(color: AppColors.greyHint),
                ),
                Text(
                  widget.Costmor,
                  style:
                      KTextStyle.textStyle12.copyWith(color: AppColors.black),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "رقم الطرد :  ",
                  style: KTextStyle.textStyle12
                      .copyWith(color: AppColors.greyHint),
                ),
                Text(
                  widget.NumberParcels,
                  style:
                      KTextStyle.textStyle12.copyWith(color: AppColors.black),
                ),
                SizedBox(
                  width: 60.w,
                ),
                Text(
                  "اجمالي الطرود :  ",
                  style: KTextStyle.textStyle12
                      .copyWith(color: AppColors.greyHint),
                ),
                Text(
                  widget.TotalNumber,
                  style:
                      KTextStyle.textStyle12.copyWith(color: AppColors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
