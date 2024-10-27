import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/o_choose_part_button_widget.dart';
import 'package:sindbad_management_app/core/utils/route.dart';

class StoreHomePageItemWidget extends StatelessWidget {
  const StoreHomePageItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> parts = [
      {
        "name": "اضافة منتج",
        "route": AppRouter.storeRouters.kStoreAddProduct,
        "partCount": "7",
      },
      {
        "name": "قائمة المنتجات",
        "route": AppRouter.storeRouters.kStoreProducts,
        "partCount": "7",
      },
      {
        "name": "بحث عن منتج",
        "route": AppRouter.storeRouters.kStoreSearchProduct,
        "partCount": "7",
      },
      {
        "name": "العروض",
        "route": AppRouter.storeRouters.kStoreOffer,
        "partCount": "7",
      },
      {
        "name": "ايقاف منتج",
        "route": AppRouter.storeRouters.kStoreStopProduct,
        "partCount": "7",
      },
      {
        "name": "المنتجات التي بها عروض",
        "route": AppRouter.storeRouters.kStoreOfferProduct,
        "partCount": "7",
      },
      {
        "name": "المنتجات الموقوفة",
        "route": AppRouter.storeRouters.kStoreStoppedProduct,
        "partCount": "7",
      },
      {
        "name": "ملف اكسل",
        "route": AppRouter.storeRouters.kStoreExcelFile,
        "partCount": "7",
      },
      {
        "name": "تقارير",
        "route": AppRouter.storeRouters.kStoreReport,
        "partCount": "7",
      },
    ];

    // only for now
    //const int partCount = 7;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: ListView.builder(
                itemCount: parts.length,
                itemBuilder: (context, index) {
                  return CustomLabelPart(
                    partName: parts[index]["name"]!,
                    partCount: parts[index]["partCount"]!,
                    navigatorName: parts[index]["route"]!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
