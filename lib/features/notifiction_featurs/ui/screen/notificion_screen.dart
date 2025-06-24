import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/repo/notifiction_repo_impl.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/get_notifiction_use_case.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/read_notificton_use_case.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/nutifiction_cubit/notifiction_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/read_notifction_cubit/read_notifiction_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/widget/notificion_body.dart';

class NotificionScreen extends StatelessWidget {
  const NotificionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotifictionCubit(
              GetNotifictionUseCase(getit.get<NotifictionRepoImpl>())),
        ),
        BlocProvider(
          create: (context) => ReadNotifictionCubit(ReadNotifictonUseCase(
              notifictionRepo: getit.get<NotifictionRepoImpl>())),
        ),
      ],
      child: const Scaffold(
        body: NotificionBody(),
      ),
    );
  }
}
