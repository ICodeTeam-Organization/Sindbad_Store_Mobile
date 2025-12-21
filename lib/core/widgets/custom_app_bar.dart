import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/core/widgets/icon_button.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';
import 'package:sindbad_management_app/features/root.dart';

import '../../config/styles/Colors.dart';

class CustomAppBar extends StatefulWidget {
  final String tital;
  final void Function()? onBackPressed;
  final bool? isBack;
  final void Function()? onSearchPressed;
  final bool? isSearch;
  const CustomAppBar({
    super.key,
    required this.tital,
    this.onBackPressed,
    this.onSearchPressed,
    this.isBack = true,
    this.isSearch = true,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  void initState() {
    super.initState();
    // Fetch unread notifications when the app bar is initialized
    context.read<UnreadNotifictionCubit>().getUnreadNotifiction(0);
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Material(
      color: AppColors.white,
      child: SizedBox(
        height: 75.h,
        width: double.infinity.w,
        child: Stack(
          children: [
            widget.isBack == true
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: InkWell(
                          onTap: widget.onBackPressed ??
                              () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            "assets/back_appbar.svg",
                            width: 40.w,
                            height: 40.w,
                          ),
                        )),
                  )
                : SizedBox(),
            Center(
              child: Text(
                widget.tital,
                style: KTextStyle.textStyle20.copyWith(
                  color: AppColors.blackDark,
                ),
              ),
            ),
            widget.isSearch == true
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Notification icon - opens notification page
                        // Person icon - opens drawer
                        IconWidget(
                          onPressed: () =>
                              rootScaffoldKey.currentState?.openDrawer(),
                          icon: Icons.person_outline_rounded,
                        ),
                        SizedBox(width: 5.w),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => GoRouter.of(context)
                                .push(AppRoutes.notification),
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: BlocConsumer<UnreadNotifictionCubit,
                                  UnreadNotifictionState>(
                                listener: (context, state) {
                                  if (state is UnreadNotifictionSuccess) {
                                    count = 0;
                                    for (var element
                                        in state.getUnreadNotifiction) {
                                      count += element.totalUnreadCount ?? 0;
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  final icon = Icon(
                                    Icons.notifications_none_rounded,
                                    size: 26.w,
                                    color: AppColors.blackDark,
                                  );
                                  if (state is UnreadNotifictionSuccess &&
                                      count > 0) {
                                    return Badge(
                                      label: count > 99
                                          ? Text('99+')
                                          : Text(count.toString()),
                                      backgroundColor: Colors.red,
                                      child: icon,
                                    );
                                  }
                                  return count > 0
                                      ? Badge(
                                          label: count > 99
                                              ? Text('99+')
                                              : Text(count.toString()),
                                          backgroundColor: Colors.red,
                                          child: icon,
                                        )
                                      : icon;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
