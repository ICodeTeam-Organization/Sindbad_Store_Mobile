import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class AllActionButtonWidget extends StatelessWidget {
  final bool isActive;
  final String? isActiveTitleButton;
  final void Function()? onUpdateTap;
  final void Function()? onChangeStatusTap;
  final void Function()? onDeleteTap;
  const AllActionButtonWidget({
    super.key,
    required this.isActive,
    required this.isActiveTitleButton,
    required this.onUpdateTap,
    required this.onChangeStatusTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ActionButtonWidget(
          title: 'تعديل عرض',
          iconPath: "assets/update.svg",
          isSolid: false,
          onTap: onUpdateTap,
        ),
        SizedBox(height: 5.h),
        isActive
            ? ActionButtonWidget(
                title: isActiveTitleButton!,
                iconPath: "assets/stop.svg",
                isSolid: false,
                onTap: onChangeStatusTap,
              )
            : ActionButtonWidget(
                title: isActiveTitleButton!,
                iconPath: "assets/active.svg",
                isSolid: false,
                onTap: onChangeStatusTap,
              ),
        SizedBox(height: 5.h),
        ActionButtonWidget(
          title: 'حذف عرض',
          iconPath: "assets/delete.svg",
          isSolid: false,
          onTap: onDeleteTap,
        ),
      ],
    );
  }
}
