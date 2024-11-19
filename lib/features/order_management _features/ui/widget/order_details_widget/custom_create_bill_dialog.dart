import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import '../../function/image_picker_function.dart';

TextEditingController dateConroller = TextEditingController();
TextEditingController numberConroller = TextEditingController();
TextEditingController mountConroller = TextEditingController();

class CustomCreateBillDialog extends StatefulWidget {
  final String headTitle;
  final String firstTitle;
  final String secondTitle;
  final String thierdTitle;
  final GestureTapCallback onPressedSure;
  const CustomCreateBillDialog({
    super.key,
    required this.headTitle,
    required this.firstTitle,
    required this.secondTitle,
    required this.thierdTitle,
    required this.onPressedSure,
  });

  @override
  State<CustomCreateBillDialog> createState() => _CustomCreateBillDialogState();
}

class _CustomCreateBillDialogState extends State<CustomCreateBillDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildDialogTitle(context),
      titlePadding: EdgeInsets.zero,
      content: _buildDialogContent(context),
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              widget.headTitle,
              style: KTextStyle.textStyle14.copyWith(color: AppColors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              dateConroller.clear();
              numberConroller.clear();
              mountConroller.clear();
            },
            icon: SvgPicture.asset(
              "assets/cancle.svg",
              width: 20.w,
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogContent(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoRow(
              title: widget.firstTitle,
              info: dateConroller,
              isDate: true,
              context: context,
            ),
            _buildInfoRow(
              title: widget.secondTitle,
              info: numberConroller,
              isDate: false,
              context: context,
            ),
            _buildInfoRow(
              title: widget.thierdTitle,
              info: mountConroller,
              isDate: false,
              context: context,
            ),
            _buildImageSection(context),
            SizedBox(
              height: 7.h,
            ),
            StorePrimaryButton(
              title: 'تاكيد',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String title,
    required TextEditingController info,
    required bool isDate,
    required context,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: KTextStyle.textStyle12,
          ),
          SizedBox(
            width: 10.w,
          ),
          SizedBox(
            width: 220.w,
            height: 48.h,
            child: TextField(
              readOnly: isDate,
              keyboardType: TextInputType.number,
              controller: info,
              decoration: InputDecoration(
                prefixIcon: isDate
                    ? InkWell(
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
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: SizedBox(
                            width: 10.w,
                            height: 10.h,
                            child: SvgPicture.asset('assets/calendar2.svg'),
                          ),
                        )) // أيقونة التاريخ
                    : null,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.backgroundColor,
                    width: 2.w,
                  ),
                ),
              ),
              style: KTextStyle.secondaryTitle.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "صورة الفاتورة",
                  style: KTextStyle.textStyle14,
                ),
              ],
            ),
          ),
          const ImagePickerFunction(),
        ],
      ),
    );
  }
}
