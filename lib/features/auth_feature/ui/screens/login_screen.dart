import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit_state.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/widgets/show_error_dialoge.dart';
import 'package:sindbad_management_app/injection_container.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/widgets/image_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool obscureText = false;

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // يختفي الكيبورد لمن تظغط في أي مكان خارج الحقول
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: BlocProvider(
              create: (_) => getit<SignInCubit>(),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 105),
                      _buildTitleSection(),
                      SizedBox(height: 40.h),
                      _buildUserNameTextFormFeild(),
                      SizedBox(height: 25.h),
                      _buildPasswordTextFormFeild(),
                      _buildForgetPasswordText(),
                      SizedBox(height: 20.h),
                      _buildLoginButton(),
                      SizedBox(height: 15.h),
                      //  _buildRegisterText(),
                    ],
                  ))),
        ),
      ),
    );
  }

  Column _buildTitleSection() {
    return Column(
      children: [
        Image.asset(
          height: 105,
          width: 105,
          "assets/login_image.png",
        ),
        Text(
          "تسجيل الدخول",
          style: TextStyle(
            color: Color(0xff231f20),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "أهلاً بك من جديد، لقد افتقدناك.",
          style: TextStyle(
            color: Color(0xff000000),
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Row _buildRegisterText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "ليس لديك حساب؟ ",
          style: TextStyle(
            color: Color(0xff000000),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            // GoRouter.of(context)
            //     .go(AppRoutes.registerPage);
          },
          child: Text(
            "إنشاء حساب",
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Color(0xffFF746B),
              color: Color(0xffFF746B),
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector _buildForgetPasswordText() {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(AppRoutes.forgetPassword),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 15, top: 10),
          child: Text("نسيت كلمة المرور؟",
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Color(0xffFF746B),
                color: Color(0xffFF746B),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )),
        ),
      ),
    );
  }

  Column _buildLoginButton() {
    return Column(
      children: [
        BlocConsumer<SignInCubit, SigninState>(
          listener: (context, state) {
            if (state is SigninLoadFailure) {
              GoRouter.of(context).go(AppRoutes.root);

              // سويت دايلوج اذا كلمة سر خطا او رقم جوال
              ShowErrorDialoge.showErrorDialog(context, state.errorMessage);
            } else if (state is SigninSuccess) {
              GoRouter.of(context).go(AppRoutes.root);
            }
          },
          builder: (context, state) {
            if (state is SigninLoadInProgress) {
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
                  if (_formKey.currentState!.validate()) {
                    context.read<SignInCubit>().signIn(
                          phoneNumberController.text,
                          passwordController.text,
                        );
                  }
                },
              ),
            );
          },
        ),
        SizedBox(
          height: 30,
        )
        // Expanded(child: SizedBox()),
        ,
        FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Text("v" + snapshot.data!.version);
              } else {
                return Text("فشل في عرض نسخه التطبيق");
              }
            }
            return SizedBox(height: 20, child: CircularProgressIndicator());
          },
        )
      ],
    );
  }

  Column _buildPasswordTextFormFeild() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 15),
            child: Text("كلمة المرور",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
        SizedBox(
          width: 380.w,
          child: TextFormField(
            obscureText: obscureText,
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              suffixIcon: obscureText
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText; // تغيير حالة الرؤية
                        });
                      },
                      child: Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      ))
                  : InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText; // تغيير حالة الرؤية
                        });
                      },
                      child: Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
              hintText: "****************",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 255, 255, 1),
                  width: 1,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال كلمة المرور';
              }

              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildUserNameTextFormFeild() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 15),
            child: Text("رقم الجوال",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
        SizedBox(
          width: 380.w,
          child: TextFormField(
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: "5xxxxxxxxxx",
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                //  borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Color(0xffDDDDDD),
                  width: 1,
                ),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'يرجى إدخال رقم الجوال';
              }
              // تحقق من صحة رقم الجوال (مثال بسيط)
              // final phoneRegExp = RegExp(r'^\+?\d{7,15}$');
              // if (!phoneRegExp.hasMatch(value)) {
              //   return 'يرجى إدخال رقم جوال صالح';
              // }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
