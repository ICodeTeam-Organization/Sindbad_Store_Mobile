import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';

import '../../../config/styles/Colors.dart';

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
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: InkWell(
                              onTap: widget.onSearchPressed ??
                                  () => GoRouter.of(context)
                                      .push(AppRoutes.profile),
                              child: Icon(Icons.person_outline,
                                  size: 30.w, color: AppColors.blackDark),
                            )),
                      ),
                      SizedBox(width: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: InkWell(
                              onTap: widget.onSearchPressed ??
                                  () => GoRouter.of(context)
                                      .push(AppRoutes.notification),
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
                                  if (state is UnreadNotifictionSuccess) {
                                    return count > 0
                                        ? Badge(
                                            label: count > 99
                                                ? Text('99+')
                                                : Text(count.toString()),
                                            backgroundColor: Colors.red,
                                            child: Icon(
                                                Icons.notifications_none,
                                                size: 30.w,
                                                color: AppColors.blackDark),
                                          )
                                        : Icon(Icons.notifications_none,
                                            size: 30.w,
                                            color: AppColors.blackDark);
                                  }
                                  return count > 0
                                      ? Badge(
                                          label: count > 99
                                              ? Text('99+')
                                              : Text(count.toString()),
                                          backgroundColor: Colors.red,
                                          child: Icon(Icons.notifications_none,
                                              size: 30.w,
                                              color: AppColors.blackDark),
                                        )
                                      : Icon(Icons.notifications_none,
                                          size: 30.w,
                                          color: AppColors.blackDark);
                                },
                              ),
                            )),
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
