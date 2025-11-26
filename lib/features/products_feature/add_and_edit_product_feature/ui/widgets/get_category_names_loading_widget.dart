import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget_for_state_cubit.dart';

class GetCategoryNamesLoadingWidget extends StatelessWidget {
  const GetCategoryNamesLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر الفئة', hintText: "جاري التحميل..."),
        SizedBox(
          height: 10.h,
        ),
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر قسم الفئة', hintText: "جاري التحميل..."),
        SizedBox(
          height: 10.h,
        ),
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر إسم البراند', hintText: "جاري التحميل..."),
      ],
    );
  }
}
