import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/functions/image_picker_function.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomDataDialogWidget extends StatelessWidget {
  // final String date;
  // final String dateContent;
  // final String invoiceNumber;
  // final int invoiceNumberContent;
  // final String invoiceCost;
  // final String shippingCompany;
  final String headTitle;
  final String firstTitle;
  final String firstTitleContent;
  final String secondTitle;
  final String secondTitleContent;
  final String thierdTitle;
  final String thierdTitleContent;
  

  const CustomDataDialogWidget({
    super.key, 
    required this.headTitle, 
    required this.firstTitle, 
    required this.firstTitleContent, 
    required this.secondTitle, 
    required this.secondTitleContent, 
    required this.thierdTitle, 
    required this.thierdTitleContent,
    // required this.date,
    // required this.invoiceNumber,
    // required this.invoiceValue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildDialogTitle(context),
      content: _buildDialogContent(),
    );
  }

  Widget _buildDialogTitle(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel),
        ),
        // const StoreTextTitleDialogWidget(textDialog: "بيانات الفاتورة"),
        Text(
          headTitle,
        style: 
        KTextStyle.secondaryTitle.copyWith(color: AppColors.black),
        // TextStyle(
        //   color:Colors.grey,fontSize: 14.sp, fontWeight: FontWeight.w700
          // ),
          ),
      ],
    );
  }

  Widget _buildDialogContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: double.infinity,
      height: 350.h,
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoRow(firstTitle, firstTitleContent),
            _buildInfoRow(secondTitle, secondTitleContent),
            _buildInfoRow(thierdTitle, thierdTitleContent),
            _buildImageSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String info) {
    return 
    Padding(
      padding:  EdgeInsets.only(bottom: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // StoreTextTitleDialogWidget(textDialog: "$title  "),
          Text(
            title,
          style: 
          KTextStyle.secondaryTitle.copyWith(color: AppColors.greyHint),),
          // TextStyle(color:Colors.grey,fontSize: 14.sp, fontWeight: FontWeight.w700),),
          ///
          // Container(
          //   width: 160.w,
          //   height: 30.h,
          //   alignment: Alignment.center,
          //   decoration: BoxDecoration(
          //     border: Border.all(
          //       // color: AppColors.scaffColor,
          //       color: AppColors.backgroundColor,
          //       width: 2.w,
          //     ),
          //   ),
          //   // child: StoreTextInfoDialogWidget(textDialog: info),
          //   child:Text(
          //     info,
          //     style: KTextStyle.secondaryTitle.copyWith(color: AppColors.black),
          //     // style: TextStyle(color:Colors.black,fontSize: 14.sp, fontWeight: FontWeight.w700),),
          // ),)
           const Spacer(),
           SizedBox(
              width: 140.w,
              child: TextField(
                controller: TextEditingController(text: info),
                decoration: InputDecoration(
                  
                  contentPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
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

  Widget _buildImageSection() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          child: 
          // const StoreTextTitleDialogWidget(textDialog: "صورة الفاتورة"),
          Text("صورة الفاتورة",
          style: 
          KTextStyle.secondaryTitle.copyWith(color: AppColors.black),),
          // TextStyle(color:Colors.black,fontSize: 14.sp, fontWeight: FontWeight.w700),)
        ),
        const KImagePickerFunction(),
      ],
    );
  }
}