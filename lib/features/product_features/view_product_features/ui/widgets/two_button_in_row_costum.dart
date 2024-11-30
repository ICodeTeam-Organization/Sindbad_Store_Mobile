import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import '../../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/styles/Colors.dart';

class TwoButtonInRow extends StatelessWidget {
  const TwoButtonInRow({
    super.key,
    // required this.productCheckedByNames,
    this.titleRight = "إضافة منتج",
    this.titleLeft = "إيقاف منتج",
    // required this.onTapRight,
    required this.onTapLeft,
  });

  // final List<String> productCheckedByNames;
  final String titleRight;
  final String titleLeft;
  // final void Function() onTapRight;
  final void Function() onTapLeft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: 30.h, left: 15.w, right: 15.w, bottom: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StorePrimaryButton(
            disabled: false, //productCheckedByNames.isNotEmpty ? true : false,
            title: titleRight,
            icon: Icons.add_circle_outline_rounded,
            buttonColor: AppColors.primary,
            height: 55.h,
            width: 150.w,
            onTap: () {
              context.push(AppRouter.storeRouters.kStoreAddProduct); //////////
            },
          ),
          StorePrimaryButton(
            title: titleLeft,
            icon: Icons.delete_outline_rounded,
            buttonColor: AppColors.primary,
            height: 55.h,
            width: 150.w,
            onTap: onTapLeft,
          )
        ],
      ),
    );
  }
}
