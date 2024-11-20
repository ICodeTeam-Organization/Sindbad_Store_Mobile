import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';

TextEditingController printConroller = TextEditingController();

class CustomOrderPrintDialog extends StatelessWidget {
  const CustomOrderPrintDialog({
    super.key,
    required this.headTitle,
    required this.onPressedPrint,
    required this.onPressedShare,
    required this.copy,
  });
  final String headTitle;
  final GestureTapCallback onPressedPrint;
  final GestureTapCallback onPressedShare;
  final int copy;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitle(
        headTitle: headTitle,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildDialogContent(
        onPressedPrint: onPressedPrint,
        onPressedShare: onPressedShare,
        copy: copy,
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildInfoRowAdd extends StatefulWidget {
  BuildInfoRowAdd({super.key, required this.copy});
  int? copy;

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
            'عدد النسخ',
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
              width: 40.w,
              height: 50.h,
              child: IconButton(
                iconSize: 24,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    widget.copy = (widget.copy! + 1);
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
            width: 55.w,
            height: 60.h,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grey),
                    borderRadius: BorderRadius.circular(16.r)),
                child: Center(
                  child: Text(
                    '${widget.copy}',
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
              width: 40.w,
              height: 50.h,
              child: IconButton(
                iconSize: 24,
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    widget.copy = (widget.copy! - 1);
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

class BuildDialogContent extends StatelessWidget {
  const BuildDialogContent({
    super.key,
    required this.onPressedPrint,
    required this.onPressedShare,
    required this.copy,
  });
  final GestureTapCallback onPressedPrint;
  final GestureTapCallback onPressedShare;
  final int copy;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.15,
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BuildInfoRowAdd(
              copy: copy,
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StorePrimaryButton(
                  width: 145.w,
                  title: 'طباعة',
                  onTap: onPressedPrint,
                ),
                SizedBox(
                  width: 5.w,
                ),
                StorePrimaryButton(
                  icon: Icons.picture_as_pdf,
                  buttonColor: AppColors.greyDark,
                  width: 145.w,
                  title: 'مشاركة',
                  onTap: onPressedShare,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDialogTitle extends StatelessWidget {
  const BuildDialogTitle({super.key, required this.headTitle});
  final String headTitle;
  @override
  Widget build(BuildContext context) {
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
              headTitle,
              style: KTextStyle.textStyle14.copyWith(color: AppColors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              printConroller.clear();
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
