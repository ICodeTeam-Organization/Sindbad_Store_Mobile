import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'build_dialog_content.dart';
import 'custom_create_bill_dialog.dart';

class ShowDatePicker extends StatefulWidget {
  const ShowDatePicker({
    super.key,
  });

  @override
  State<ShowDatePicker> createState() => _ShowDatePickerState();
}

class _ShowDatePickerState extends State<ShowDatePicker> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        DateTime? pickeddate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime(2101),
        );
        if (pickeddate != null) {
          setState(
            () {
              dateConroller.text = DateFormat('yyyy/MM/dd').format(pickeddate);
            },
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.all(7),
        child: SizedBox(
          width: 8.w,
          height: 8.h,
          child: SvgPicture.asset('assets/calendar2.svg'),
        ),
      ),
    );
  }
}
