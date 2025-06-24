import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/widget/nottfiction_item_widget.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/widget/tab_bar_notifiction_widget.dart';

class NotificionBody extends StatefulWidget {
  const NotificionBody({super.key});

  @override
  State<NotificionBody> createState() => _NotificionBodyState();
}

class _NotificionBodyState extends State<NotificionBody> {
  @override
  void initState() {
    super.initState();

    context.read<UnreadNotifictionCubit>().getUnreadNotifiction(0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(bottom: 25.h),
        child: const CustomAppBar(
          tital: 'الاشعارات',
          isSearch: false,
        ),
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: BlocBuilder<UnreadNotifictionCubit, UnreadNotifictionState>(
            builder: (context, state) {
          if (state is UnreadNotifictionLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UnreadNotifictionSuccess) {
            return Expanded(
              child: CustomTabBarWidget(
                tabViews: const [
                  NottifictionItem(
                    type: 0,
                  ),
                  NottifictionItem(
                    type: 1,
                  ),
                  NottifictionItem(
                    type: 2,
                  ),
                ],
                tabs: [
                  Tab(
                    child: TabBarNotifictionWidget(
                      title: 'كل الاشعارات',
                      counter: state.getUnreadNotifiction.allNotfiction,
                    ),
                  ),
                  Tab(
                    child: TabBarNotifictionWidget(
                      title: 'اشعارات الطلبات',
                      counter: state.getUnreadNotifiction.specialOrderOnly,
                    ),
                  ),
                  Tab(
                    child: TabBarNotifictionWidget(
                      title: 'اشعارات الشحنات',
                      counter: state.getUnreadNotifiction.orderOnly,
                    ),
                  ),
                ],
                length: 3,
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    ]);
  }
}
