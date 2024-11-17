import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/features/auth_features/ui/widget/text_form.dart';
import '../../../../core/setup_service_locator.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import '../../../../core/utils/route.dart';
import '../../../../core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../data/repos_impl/sign_in_repo_impl.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../manager/cubit/sign_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    @override
    void dispose() {
      super.dispose();
      phoneController.dispose();
      passwordController.dispose();
    }

    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignInCubit(
            SignInUseCase(
              getit.get<SignInRepoImpl>(),
            ),
          ),
          child: Container(
            color: Color(0xffF6F5F6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('مرحبا',
                    style: KTextStyle.primaryTitle
                        .copyWith(color: AppColors.colorButton)),
                Text('يرجى تسجيل الدخول الى محلك',
                    style: KTextStyle.textStyle14),
                TextForm(
                  labelText: 'رقم الجوال',
                  controller: phoneController,
                  textInputType: TextInputType.number,
                ),
                TextForm(
                  labelText: 'كلمة السر',
                  controller: passwordController,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: BlocConsumer<SignInCubit, SignInState>(
                    listener: (context, state) {
                      if (state is SignInFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(state.errorMessage.toString())),
                        );
                        print(state.errorMessage);
                      } else if (state is SignInSuccess) {
                        if (state.user.userRoles[0] == 'Store') {
                          context.push(AppRouter.storeRouters.root);
                          phoneController.clear();
                          passwordController.clear();
                        }
                      }
                    },
                    builder: (context, state) {
                      return StorePrimaryButton(
                        height: 44.h,
                        title: "تسجيل الدخول",
                        onTap: () async {
                          await context.read<SignInCubit>().signIn(
                                phoneController.text,
                                passwordController.text,
                              );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
