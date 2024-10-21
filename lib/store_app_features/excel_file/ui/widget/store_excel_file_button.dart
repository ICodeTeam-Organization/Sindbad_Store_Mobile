import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

class StoreExcelFileButton extends StatelessWidget {
  const StoreExcelFileButton({
    super.key,
    required this.buttonName,
    /* required this.routeName,*/
  });
  final String buttonName;
  /*final String routeName;*/

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /*Navigator.of(context).pushNamed(routeName);*/
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        width: 200.w,
        height: 50.h,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            border: Border.all(color: Colors.grey, width: 2.w),
            borderRadius: BorderRadius.circular(25.r)),
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
