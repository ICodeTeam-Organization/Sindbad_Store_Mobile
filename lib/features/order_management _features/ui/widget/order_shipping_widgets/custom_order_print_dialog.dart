import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import '../../function/pdf.dart';
import 'build_info_row_add.dart';

TextEditingController printConroller = TextEditingController();

class CustomOrderPrintDialog extends StatelessWidget {
  const CustomOrderPrintDialog({
    super.key,
    required this.headTitle,
    required this.onPressedPrint,
    required this.onPressedShare,
    required this.billNumber,
    required this.storeNumber,
  });
  final String headTitle;
  final GestureTapCallback onPressedPrint;
  final GestureTapCallback onPressedShare;
  final int billNumber;
  final int storeNumber;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: BuildDialogTitle(
        headTitle: headTitle,
      ),
      titlePadding: EdgeInsets.zero,
      content: BuildDialogContent(
        onPressedPrint: () async {
          final pdfFile = await Pdf.generateCenteredText(
              '$billNumber - $storeNumber', parcels);
        },
        onPressedShare: () async {
          // الحصول على المسار المؤقت
          final directory = await getTemporaryDirectory();
          final path = '${directory.path}/sample.pdf';
          final file = File(path);

          // كتابة المحتوى إلى الملف
          await file.writeAsString(share!);

          // مشاركة الملف باستخدام share_plus
          Share.shareXFiles([XFile(path)], text: 'Great picture');

          // Share.shareFiles([share], text: 'إليك هذا الملف!');
        },
      ),
    );
  }
}

class BuildDialogContent extends StatelessWidget {
  const BuildDialogContent({
    super.key,
    required this.onPressedPrint,
    required this.onPressedShare,
  });
  final GestureTapCallback onPressedPrint;
  final GestureTapCallback onPressedShare;
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
              title: 'عدد النسخ',
            ),
            SizedBox(
              height: 7.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StorePrimaryButton(
                  width: 140.w,
                  title: 'طباعة',
                  onTap: onPressedPrint,
                ),
                SizedBox(
                  width: 5.w,
                ),
                StorePrimaryButton(
                  icon: Icons.picture_as_pdf,
                  buttonColor: AppColors.greyDark,
                  width: 140.w,
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
              printConroller.clear();
              parcels = 1;
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
