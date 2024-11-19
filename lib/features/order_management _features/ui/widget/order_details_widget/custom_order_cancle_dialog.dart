import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import '../../function/image_picker_function.dart';

TextEditingController cancelConroller = TextEditingController();

class CustomOrderCancleDialog extends StatefulWidget {
  final String headTitle;
  final String firstTitle;
  final GestureTapCallback onPressedSure;
  const CustomOrderCancleDialog({
    super.key,
    required this.headTitle,
    required this.firstTitle,
    required this.onPressedSure,
  });

  @override
  State<CustomOrderCancleDialog> createState() =>
      _CustomOrderCancleDialogState();
}

class _CustomOrderCancleDialogState extends State<CustomOrderCancleDialog> {
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
              cancelConroller.clear();
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
      height: MediaQuery.sizeOf(context).height * 0.4,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoRow(
              info: cancelConroller,
            ),
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
    required TextEditingController info,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.7,
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: TextField(
              maxLines: 10,
              keyboardType: TextInputType.text,
              controller: info,
              decoration: InputDecoration(
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
}
