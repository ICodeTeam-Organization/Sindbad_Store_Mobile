import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/use_cases/get_main_and_sub_category_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/profile_repo_impl.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/get_profile_data_usecase.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/profile_body.dart';
import 'package:sindbad_management_app/injection_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProfileCubit(
              GetProfileDataUsecase(getit.get<ProfileRepoImpl>())),
        ),
        BlocProvider(
          create: (context) => GetCategoryNamesCubit(
            GetMainAndSubCategoryUseCase(
                getit.get<AddAndEditProductStoreRepoImpl>()),
          ),
        ),
      ],
      child: ProfileBody(),
    );
  }
}
