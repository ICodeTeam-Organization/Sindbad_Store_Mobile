// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

import '../../../../../core/styles/Colors.dart';

int? parcels = 1;

// ignore: must_be_immutable
class BuildInfoRowAdd extends StatefulWidget {
  BuildInfoRowAdd({super.key, required this.title});

  String? title;

  @override
  State<BuildInfoRowAdd> createState() => _BuildInfoRowAddState();
}

class _BuildInfoRowAddState extends State<BuildInfoRowAdd> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            style: KTextStyle.textStyle13,
          ),
          SizedBox(
            width: 20.w,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(100.r)),
            child: SizedBox(
              width: 35.w,
              height: 38.h,
              child: IconButton(
                iconSize: 20,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    parcels = (parcels! + 1);
                    // count = widget.parcels;
                  });
                },
                icon: Icon(Icons.add),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          SizedBox(
            width: 48.w,
            height: 52.h,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(12.r)),
                child: Center(
                  child: Text(
                    '$parcels',
                    style: KTextStyle.textStyle12,
                  ),
                )),
          ),
          SizedBox(
            width: 20.w,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(100.r)),
            child: SizedBox(
              width: 35.w,
              height: 38.h,
              child: IconButton(
                iconSize: 20,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    parcels = (parcels! - 1);
                    // count = widget.parcels;
                  });
                },
                icon: Icon(Icons.cancel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
