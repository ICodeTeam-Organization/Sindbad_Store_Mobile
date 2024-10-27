import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/widgets/custom_search_widget.dart';
import 'package:sindbad_management_app/store_app_features/excel_file/ui/widget/button_sure.dart';
import 'package:sindbad_management_app/store_app_features/excel_file/ui/widget/store_excel_file_button.dart';

class ExcelFileBody extends StatelessWidget {
  const ExcelFileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        KCustomSearchWidget(hintText: "بحث برقم الطلب"),
        Container(
          margin: EdgeInsets.symmetric(vertical: 40.h, horizontal: 10.w),
          child: Column(
            children: [
              StoreExcelFileButton(
                buttonName: "اضافة منتجات",
                onPressed: () {},
              ),
              StoreExcelFileButton(
                buttonName: "تعديل منتجات",
                onPressed: () {},
              ),
              StoreExcelFileButton(
                buttonName: "ايقاف منتجات",
                onPressed: () {},
              ),
              StoreExcelFileButton(
                buttonName: "اعادة تفعيل منتجات",
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100.h,
        ),
        const ButtonSure(),
      ],
    );
  }
}
