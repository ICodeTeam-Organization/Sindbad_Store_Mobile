import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/widgets/custom_appbar_widget.dart';
import 'package:sindbad_management_app/store_app_features/excel_file/ui/widget/excel_file_body.dart';

class StoreExcelFile extends StatelessWidget {
  const StoreExcelFile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            KCustomAppBarWidget(
              nameAppbar: "ملف اكسل",
              count: 0,
              isHome: false,
            ),
            ExcelFileBody(),
          ],
        ),
      ),
    );
  }
}
