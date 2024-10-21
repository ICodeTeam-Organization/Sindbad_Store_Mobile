import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/core/widgets/custom_button_with_count_widget.dart';

class StoreHomePageItemWidget extends StatelessWidget {
  const StoreHomePageItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreAddProduct,
              partName: "اضافة منتج",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreProducts,
              partName: "قائمة المنتجات",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreSearchProduct,
              partName: "بحث عن منتج",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreOffer,
              partName: "العروض",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreStopProduct,
              partName: "ايقاف منتج",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreOfferProduct,
              partName: "المنتجات التي بها عروض",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreStoppedProduct,
              partName: "المنتجات الموقوفة",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreExcelFile,
              partName: "ملف اكسل",
              partCount: 7,
            ),
            KCustomButtonWithCountWidget(
              navigatorName: AppRouter.storeRouters.kStoreReport,
              partName: "تقارير",
              partCount: 7,
            ),
          ],
        ),
      ),
    );
  }
}
