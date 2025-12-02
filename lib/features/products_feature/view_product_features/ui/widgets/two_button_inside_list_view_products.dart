import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class TwoButtonInsideListViewProducts extends StatelessWidget {
  const TwoButtonInsideListViewProducts({
    super.key,
    required this.onTapEdit,
    required this.onTapDeleteOrReactivate,
    required this.reactivate,
  });

  final void Function() onTapEdit;
  final void Function() onTapDeleteOrReactivate;
  final bool reactivate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButtonWidget(
          title: 'تعديل المنتج',
          iconPath: "assets/update.svg",
          isSolid: false,
          onTap: onTapEdit,
        ),
        SizedBox(height: 5.h),
        ActionButtonWidget(
          title: reactivate ? 'إعادة تنشيط' : 'حذف المنتج',
          iconPath:
              reactivate ? 'assets/change_status.svg' : 'assets/delete.svg',
          isSolid: false,
          onTap: onTapDeleteOrReactivate,
        ),
      ],
    );
  }
}
