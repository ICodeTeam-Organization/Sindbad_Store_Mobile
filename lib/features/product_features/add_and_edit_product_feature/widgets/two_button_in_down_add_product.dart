import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../core/styles/Colors.dart';
import '../ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class TwoButtonInDownAddproduct extends StatelessWidget {
  const TwoButtonInDownAddproduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StorePrimaryButton(
          onTap: () {
            // ================ for test ============
            context.read<GetCategoryNamesCubit>().getMainAndSubCategory(
                filterType: 2, pageNumper: 1, pageSize: 10);
          },
          title: "تأكيد",
          width: 251.w,
          height: 44.h,
          buttonColor: AppColors.primary,
        ),
        SizedBox(
          width: 8.w,
        ),
        StorePrimaryButton(
          onTap: () {
            context.read<AddProductToStoreCubit>().test();
          },
          title: "إلغاء",
          width: 104.w,
          height: 46.h,
          buttonColor: AppColors.greyIcon,
        ),
      ],
    );
  }
}
