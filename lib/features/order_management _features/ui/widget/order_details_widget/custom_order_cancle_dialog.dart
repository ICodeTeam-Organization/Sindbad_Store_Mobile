import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

// TextEditingController cancelConroller = TextEditingController();

class CustomOrderCancleDialog extends StatelessWidget {
  const CustomOrderCancleDialog(
      {super.key,
      required this.headTitle,
      required this.onPressedSure,
      required this.cancelConroller});
  final String headTitle;
  final GestureTapCallback onPressedSure;
  final TextEditingController cancelConroller;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitleCAncel(
        headTitle: headTitle,
        cancelController: cancelConroller,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildDialogContent(
        onPressedSure: onPressedSure,
        cancelConroller: cancelConroller,
      ),
    );
  }
}

class BuildDialogContent extends StatelessWidget {
  const BuildDialogContent(
      {super.key, required this.onPressedSure, required this.cancelConroller});
  final GestureTapCallback onPressedSure;
  final TextEditingController cancelConroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.32,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BuildInfoRow(
              info: cancelConroller,
            ),
            SizedBox(
              height: 5.h,
            ),
            StorePrimaryButton(
              title: 'تاكيد',
              onTap: onPressedSure,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildInfoRow extends StatelessWidget {
  BuildInfoRow({super.key, required this.info});
  TextEditingController info = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.h),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.25,
        child: TextField(
          maxLines: 10,
          // keyboardType: TextInputType.text,
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
    );
  }
}

class BuildDialogTitleCAncel extends StatelessWidget {
  const BuildDialogTitleCAncel({
    super.key,
    required this.headTitle,
    required this.cancelController,
  });
  final String headTitle;
  final TextEditingController cancelController;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              headTitle,
              style: KTextStyle.textStyle14.copyWith(color: AppColors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              cancelController.clear();
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
}
