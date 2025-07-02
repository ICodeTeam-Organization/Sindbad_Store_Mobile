import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/widget/nottfiction_item_widget.dart';

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
    return Column(
      children: [
        const CustomAppBar(
          tital: 'الاشعارات',
          isSearch: false,
        ),
        Expanded(
          // ✅ This solves the issue!
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: BlocBuilder<UnreadNotifictionCubit, UnreadNotifictionState>(
              builder: (context, state) {
                if (state is UnreadNotifictionLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is UnreadNotifictionSuccess) {
                  return NottifictionItem(type: 0); // ← Contains ListView
                } else if (state is UnreadNotifictionFailure) {
                  return Center(
                    child: Text(
                      state.failure,
                      style: TextStyle(fontSize: 16.sp, color: Colors.red),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
