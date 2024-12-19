import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/custom_dropdown_widget_for_state_cubit.dart';

class GetCategoryNamesInitialWidget extends StatelessWidget {
  const GetCategoryNamesInitialWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر الفئة',
            hintText: "تأكد من إتصالك بالإنترنت, أعد المحاولة"),
        SizedBox(
          height: 10.h,
        ),
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر قسم الفئة',
            hintText: "تأكد من إتصالك بالإنترنت, أعد المحاولة"),
        SizedBox(
          height: 10.h,
        ),
        CustomDropdownWidgetForStateCubit(
            textTitle: 'أختر إسم البراند',
            hintText: "تأكد من إتصالك بالإنترنت, أعد المحاولة"),
      ],
    );
  }
}
