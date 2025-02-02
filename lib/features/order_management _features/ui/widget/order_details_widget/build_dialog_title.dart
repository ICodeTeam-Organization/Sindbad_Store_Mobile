import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/drop_down_widget.dart';
import '../order_shipping_widgets/build_info_row_add.dart';
import '../order_shipping_widgets/build_shipping_dialog_content.dart';
import 'build_dialog_content.dart';

class BuildDialogTitle extends StatelessWidget {
  const BuildDialogTitle({super.key, required this.headTitle});
  final String headTitle;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5.r)),
        color: AppColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              headTitle,
              style: KTextStyle.textStyle14.copyWith(color: AppColors.white),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              dateConroller.clear();
              numberConroller.clear();
              mountConroller.clear();
              numberShippingConroller.clear();
              mountShippingConroller.clear();
              anotherCompanyConroller.clear();
              anotherCompanyNumberConroller.clear();
              parcels = 1;
              companyName = '';
            },
            icon: SvgPicture.asset(
              "assets/cancle.svg",
              width: 20.w,
              height: 20.h,
            ),
          ),
        ],
      ),
    );
  }
}
