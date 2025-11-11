import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/widget/order_shipping_widgets/drop_down_widget.dart';
import '../order_shipping_widgets/build_info_row_add.dart';

class BuildDialogTitleShipping extends StatelessWidget {
  const BuildDialogTitleShipping({
    super.key,
    required this.headTitle,
    required this.dateController,
    required this.numberShippingController,
    required this.mountShippingController,
    required this.anotherCompanyController,
    required this.anotherCompanyNumberController,
  });
  final String headTitle;
  final TextEditingController dateController;

  final TextEditingController numberShippingController;

  final TextEditingController mountShippingController;

  final TextEditingController anotherCompanyController;

  final TextEditingController anotherCompanyNumberController;

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
              dateController.clear();
              numberShippingController.clear();
              mountShippingController.clear();
              anotherCompanyController.clear();
              anotherCompanyNumberController.clear();
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
