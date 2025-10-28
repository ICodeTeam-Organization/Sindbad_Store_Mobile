import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/change_password_body.dart';

import '../../../../injection_container.dart';
import '../../../auth_feature/data/repository/authentation_repository_imp.dart';
import '../../../auth_feature/domain/usecase/reset_password_use_case.dart';
import '../../../auth_feature/ui/reset_password_cubit/reset_password_cubit_cubit.dart';

class ChnagePasssowrdScreen extends StatelessWidget {
  const ChnagePasssowrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubitCubit(ResetPasswordUseCase(
        getit.get<AuthentationRepositoryImp>(),
      )),
      child: ChangePasswordBody(),
    );
  }
}
