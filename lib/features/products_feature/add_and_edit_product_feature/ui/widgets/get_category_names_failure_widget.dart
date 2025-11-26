import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget_for_state_cubit.dart';

class GetCategoryNamesFailureWidget extends StatelessWidget {
  const GetCategoryNamesFailureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر الفئة', hintText: "فشل التحميل, أعد المحاولة"),
        SizedBox(
          height: 10.h,
        ),
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر قسم الفئة', hintText: "فشل التحميل, أعد المحاولة"),
        SizedBox(
          height: 10.h,
        ),
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر اسم البراند',
            hintText: "فشل التحميل, أعد المحاولة"),
      ],
    );
  }
}
