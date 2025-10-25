import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/injection_container.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/core/utils/currancy.dart';
import 'package:sindbad_management_app/core/utils/key_name.dart';
import 'package:sindbad_management_app/config/routers/route.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repo/auth_repo_impl.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/widgets/build_text_field.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/widgets/image_login.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/widgets/show_error_dialoge.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF6F5F6),
        body: GestureDetector(
          onTap: () {
            //يختفي الكيبورد لمن تظغط في أي مكان خارج الحقول
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) =>
                  SignInCubitCubit(SignInUseCase(getit.get<AuthRepoImpl>())),
              child: Column(
                children: [
                  //ذي وديجت حق صوره
                  ImageLogin(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    images: "assets/image_4_login-removebg-preview.png",
                    width: 335,
                  ),
                  SizedBox(height: 30.h),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "مرحباً ",
                          style: TextStyle(
                            color: Color(0xff231f20),
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "تسجيل دخول مالك المحل ",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        //ذي وديجت حقل
                        buildTextField(
                          visible: null,
                          hinttext: "رقم الجوال",
                          controller: phoneNumberController,
                        ),
                        SizedBox(height: 25.h),
                        buildTextField(
                            hinttext: "كلمة المرور",
                            controller: passwordController,
                            type: TextInputType.text,
                            visible: false)
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 60.h),
                      BlocConsumer<SignInCubitCubit, SignInCubitState>(
                        listener: (context, state) {
                          if (state is SignInCubitFailure) {
                            // سويت دايلوج اذا كلمة سر خطا او رقم جوال
                            ShowErrorDialoge.showErrorDialog(
                                context, state.errorMessage);
                          } else if (state is SignInCubitSuccess) {
                            if (state.user.userRoles[0] == "Store") {
                              secureStorage.write(
                                  key: KeyName.country,
                                  value: state.user.userCuntry);
                              Currancy.initCurrency();
                              GoRouter.of(context).go(AppRoutes.root);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "ليس لديك الصلاحيه لاستخدم هذا التطبيق"),
                                ),
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          if (state is SignInCubitLoading) {
                            return Container(
                              width: 380.w,
                              height: 47.h,
                              decoration: BoxDecoration(
                                color: Color(0xffFF746B),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                child: CircularProgressIndicator(
                                  strokeAlign: -2,
                                  // strokeWidth: 5,
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          }
                          return Container(
                            width: 380.w,
                            height: 47.h,
                            decoration: BoxDecoration(
                              color: Color(0xffFF746B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MaterialButton(
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                context.read<SignInCubitCubit>().signIn(
                                      phoneNumberController.text,
                                      passwordController.text,
                                    );
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  ImageLogin(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      images: "assets/image_3_login-removebg-preview.png",
                      width: 205)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
