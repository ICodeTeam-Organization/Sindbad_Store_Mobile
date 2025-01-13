import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import '../../../features/order_management _features/ui/widget/order_details_widget/build_dialog_content.dart';
import '../../styles/Colors.dart';

// ignore: must_be_immutable
class DateTextField extends StatefulWidget {
  DateTextField({super.key, required this.title, required this.controller});
  final String title;
  TextEditingController controller = TextEditingController();

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              widget.title,
              style:
                  KTextStyle.textStyle12.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          // Spacer(),
          Expanded(
            child: SizedBox(
              // width: 200.w,
              height: 48.h,
              child: TextField(
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
                        dateConroller.text =
                            DateFormat('yyyy/MM/dd').format(pickeddate);
                      },
                    );
                  }
                },
                readOnly: true,
                keyboardType: TextInputType.number,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: 'انقر لعرض التاريخ',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(7),
                    child: SizedBox(
                      width: 8.w,
                      height: 8.h,
                      child: SvgPicture.asset('assets/calendar2.svg'),
                    ),
                    // ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.grey,
                      width: 1.w,
                    ),
                  ),
                ),
                style: KTextStyle.textStyle12
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
