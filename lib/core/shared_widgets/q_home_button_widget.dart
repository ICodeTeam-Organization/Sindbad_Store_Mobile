import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
class PrimaryButtonWidget extends StatefulWidget {
  const PrimaryButtonWidget({super.key, required this.buttonName, required this.buttonIcon, required this.navigatorName,});
  final String buttonName;
  //final Icon buttonIcon;
  final IconData buttonIcon;
  final String navigatorName;
  @override
  State<PrimaryButtonWidget> createState() => _PrimaryButtonWidgetState();
}

class _PrimaryButtonWidgetState extends State<PrimaryButtonWidget> {



  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryButtonColor,
        borderRadius: BorderRadius.circular(10.r)
      ),
      width: double.infinity,
      margin:  EdgeInsets.symmetric(vertical: 4.h , horizontal: 10.w),
      padding:  EdgeInsets.symmetric(vertical: 3.h,horizontal: 10.w),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushNamed(widget.navigatorName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                  //child:  widget.buttonIcon,
                  child:  Icon(widget.buttonIcon,size: 30.sp,color: AppColors.primaryColor),
                  ),
                    Text(widget.buttonName ,style:  TextStyle(fontWeight: FontWeight.bold ,fontSize: 20.sp, color: Colors.white),)
                    ],
                )),
    );
  }
}