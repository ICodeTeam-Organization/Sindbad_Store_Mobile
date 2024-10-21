// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:sindbad_management_app/core/styles/Colors.dart';
// import 'package:sindbad_management_app/core/styles/text_style.dart';
// import 'package:sindbad_management_app/features/accounts_features/store_app_features/order_processing/ui/widget/store_text_info_dialog_widget.dart';
// import 'package:sindbad_management_app/features/accounts_features/store_app_features/order_processing/ui/widget/store_text_title_dialog_widget.dart';

// class KCustomPrintDialogWidget extends StatelessWidget {
//   const KCustomPrintDialogWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//   return  AlertDialog(
//             title: Row(
//                   children: [
//                     IconButton(onPressed: (){
//                       Navigator.of(context).pop();
//                     }, icon: const Icon(Icons.cancel)),
//                     // const StoreTextTitleDialogWidget(textDialog: "طباعة العنوان",)
//                     Text(
//                       "طباعة العنوان",
//                     style: 
//                     KTextStyle.secondaryTitle.copyWith(color: AppColors.greyLight))
//                     // TextStyle(color:Colors.grey,fontSize: 14.sp, fontWeight: FontWeight.w700),);
//                   ],
//                 ),

//             content: Container(
//               padding: EdgeInsets.symmetric(vertical: 5.h),
//               width: double.infinity,
//               height: 80.h,
//               color: AppColors.white,
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       const StoreTextTitleDialogWidget(textDialog: "عدد النسخ  ",),
//                       Container(
//                         width: 160.w,
//                         height: 30.h,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: AppColors.scaffColor,
//                             color: AppColors.backgroundColor,
//                             width: 2.w
//                             )
//                         ),
//                         child:
//                         // const StoreTextInfoDialogWidget(textDialog: "1",) ,
//                         Text("1",
//                         style: 
//                         // TextStyle(color:Colors.grey,fontSize: 14.sp, fontWeight: FontWeight.w700),
//                         KTextStyle.primaryTitle.copyWith(color: AppColors.greyLight)
//                         ),
//                       )
//                     ],
//                   ),
//                   ///////////////////////////////////////////////////////
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
                       
//                       // StoreTextTitleDialogWidget(textDialog: "الطابعة  ",),
//                       Text("الطابعة",
//                       style: 
//                       // TextStyle(color:Colors.grey,fontSize: 14.sp, fontWeight: FontWeight.w700),
//                       KTextStyle.primaryTitle.copyWith(color: AppColors.greyLight)
//                       ),
//                       Container(
//                         width: 160.w,
//                         height: 30.h,
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: AppColors.scaffColor,
//                             color: AppColors.backgroundColor,
//                             width: 2.w
//                             )
//                         ),
//                         child:
//                         // const StoreTextInfoDialogWidget(textDialog: "",) ,
//                          Text("",
//                       style: 
//                       KTextStyle.primaryTitle.copyWith(color: AppColors.greyLight)
//                       ),
//                       )
//                     ],
//                   ),
//                   /////////////////////////////////////////////////////////////
                  
//                   ],
//               ),
              
//             ),
//             ),
//             actions: [
//               InkWell(
//                     child: Container(
//                       width: 115.w,
//                       height: 36.h,
//                       alignment: Alignment.center,
//                       decoration:  BoxDecoration(
//                         ////
//                         color: const Color(0xffAFAAAA),
//                         ////
//                         borderRadius: BorderRadius.circular(25.r)
//                       ),
//                       child: const Text("طباعة")),
//                   ),
//                   /////////////////////////////////////////////////////////
                  

//                   InkWell(
//                     child: Container(
//                       width: 115.w,
//                       height: 36.h,
//                       alignment: Alignment.center,
//                       decoration:  BoxDecoration(
//                         ///
//                         color: const Color(0xffAFAAAA),
//                         ///
//                         borderRadius: BorderRadius.circular(25.r)
//                       ),
//                       child: const Text("مشاركة ملف pdf")),
//                   ),
//             ],
            
//             );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class KCustomPrintDialogWidget extends StatelessWidget {
  final int numberOfCopies;
  final String printName;
  const KCustomPrintDialogWidget({
    super.key, 
    required this.numberOfCopies, 
    required this.printName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _buildDialogTitle(context),
      content: _buildDialogContent(),
      actions: _buildDialogActions(),
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
        Text(
          "طباعة العنوان",
          style: KTextStyle.secondaryTitle.copyWith(color: AppColors.black),
        ),
      ],
    );
  }

  Widget _buildDialogContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      width: double.infinity,
      height: 110.h,
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoRow("عدد النسخ",numberOfCopies.toString()),
            SizedBox(height: 10.h,),
            _buildInfoRow("الطابعة",printName),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // StoreTextTitleDialogWidget(textDialog: "$title  "),
        Text(
          title,
          style: KTextStyle.secondaryTitle.copyWith(color: AppColors.greyHint),
        ),
        // Container(
        //   width: 160.w,
        //   height: 30.h,
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: AppColors.backgroundColor,
        //       width: 2.w,
        //     ),
        //   ),
        //   child: StoreTextInfoDialogWidget(textDialog: info),
        // ),
        SizedBox(width: 8.h,),
        SizedBox(
          width: 160.w,
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
    );
  }

  List<Widget> _buildDialogActions() {
    return [
      _buildActionButton("طباعة"),
      _buildActionButton("مشاركة ملف pdf"),
    ];
  }

  Widget _buildActionButton(String text) {
    return 
    InkWell(
      child: Container(
        width: 115.w,
        height: 36.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffAFAAAA),
          borderRadius: BorderRadius.circular(25.r),
        ),
        child: Text(text),
      ),
    );
  }
}