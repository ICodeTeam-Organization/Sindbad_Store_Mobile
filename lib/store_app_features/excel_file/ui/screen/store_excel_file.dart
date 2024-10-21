import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';
import 'package:sindbad_management_app/core/widgets/custom_search_widget.dart';
import 'package:sindbad_management_app/store_app_features/excel_file/ui/widget/store_excel_file_button.dart';

class StoreExcelFile extends StatelessWidget {
  const StoreExcelFile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const KCustomAppBarWidget(nameAppbar: "ملف اكسل"),
          KCustomSearchWidget(hintText: "بحث برقم الطلب"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
            child: const Column(
              children: [
                StoreExcelFileButton(
                  buttonName: "اضافة منتجات",
                ),
                StoreExcelFileButton(
                  buttonName: "تعديل منتجات",
                ),
                StoreExcelFileButton(
                  buttonName: "ايقاف منتجات",
                ),
                StoreExcelFileButton(
                  buttonName: "اعادة تفعيل منتجات",
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KCustomPrimaryButtonWidget(buttonName: "تاكيد", onPressed: () {})
            ],
          ),
        ],
      ),
    );
  }
}
