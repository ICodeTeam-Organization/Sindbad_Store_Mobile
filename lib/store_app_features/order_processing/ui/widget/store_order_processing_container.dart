import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
class StoreOrderProcessingContainer extends StatelessWidget {
  const StoreOrderProcessingContainer({super.key, required this.numberOrder, required this.date, required this.numberItem,});
  final String numberOrder;
  final String date;
  final String numberItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: const Color(0xff454545),
        borderRadius: BorderRadius.circular(10.r)
      ),
      width: 344.w,
      height: 80.h,

      child:   Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("رقم الطلب:  ", style: KTextStyle.secondaryTitle.copyWith(color: AppColors.white)),
                Text(numberOrder, style: KTextStyle.secondaryTitle.copyWith(fontWeight: FontWeight.w400,color: AppColors.white),)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Text( "التاريخ : ", style: KTextStyle.secondaryTitle.copyWith(color: AppColors.white)),
                    Text(date, style: KTextStyle.secondaryTitle.copyWith(fontWeight: FontWeight.w400,color: AppColors.white)),
                  ],
                ),
                Row(
                  children: [
                    Text("عدد الاصناف : ", style: KTextStyle.secondaryTitle.copyWith(color: AppColors.white)),
                    Text(numberItem, style: KTextStyle.secondaryTitle.copyWith(fontWeight: FontWeight.w400,color: AppColors.white))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
