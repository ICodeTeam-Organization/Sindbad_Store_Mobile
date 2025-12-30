import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit_state.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/widgets/show_error_dialoge.dart';
import 'package:sindbad_management_app/injection_container.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/setting_cubit/app_settings_cubit.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

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
                      SizedBox(height: 50.h),
                      _buildLanguageDropdown(),
                      SizedBox(height: 20.h),
                      _buildTitleSection(l10n),
                      SizedBox(height: 40.h),
                      _buildUserNameTextFormFeild(l10n, isRtl),
                      SizedBox(height: 25.h),
                      _buildPasswordTextFormFeild(l10n, isRtl),
                      _buildForgetPasswordText(l10n, isRtl),
                      SizedBox(height: 20.h),
                      _buildLoginButton(l10n),
                      SizedBox(height: 15.h),
                      //  _buildRegisterText(),
                    ],
                  ))),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xffDDDDDD)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: BlocBuilder<SettingsCubit, SettingsState>(
              bloc: getit<SettingsCubit>(),
              builder: (context, state) {
                final settingsCubit = getit<SettingsCubit>();
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: settingsCubit.localeCode,
                      icon: Icon(Icons.language, color: Color(0xffFF746B)),
                      isDense: true,
                      items: [
                        DropdownMenuItem(
                          value: 'ar',
                          child:
                              Text('العربية', style: TextStyle(fontSize: 14)),
                        ),
                        DropdownMenuItem(
                          value: 'en',
                          child:
                              Text('English', style: TextStyle(fontSize: 14)),
                        ),
                      ],
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          settingsCubit.setLocale(Locale(newValue));
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Column _buildTitleSection(AppLocalizations l10n) {
    return Column(
      children: [
        Image.asset(
          height: 105,
          width: 105,
          "assets/login_image.png",
        ),
        Text(
          l10n.login,
          style: TextStyle(
            color: Color(0xff231f20),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          l10n.welcomeBack,
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

  GestureDetector _buildForgetPasswordText(AppLocalizations l10n, bool isRtl) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).push(AppRoutes.forgetPassword),
      child: Align(
        alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(
            right: isRtl ? 15 : 0,
            left: isRtl ? 0 : 15,
            top: 10,
          ),
          child: Text(l10n.forgotPassword,
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

  Column _buildLoginButton(AppLocalizations l10n) {
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
            return SizedBox(
              width: 380.w,
              height: 47.h,
              child: Material(
                color: const Color(0xffFF746B),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInCubit>().signIn(
                            phoneNumberController.text,
                            passwordController.text,
                          );
                    }
                  },
                  child: Center(
                    child: Text(
                      l10n.login,
                      style: const TextStyle(
                        color: Color(0xffffffff),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                return Text("v${snapshot.data!.version}");
              } else {
                return Text(l10n.failedToShowVersion);
              }
            }
            return SizedBox(height: 20, child: CircularProgressIndicator());
          },
        )
      ],
    );
  }

  Column _buildPasswordTextFormFeild(AppLocalizations l10n, bool isRtl) {
    return Column(
      children: [
        Align(
          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 8.0,
              right: isRtl ? 15 : 0,
              left: isRtl ? 0 : 15,
            ),
            child: Text(l10n.password,
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
              suffixIcon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: IconButton(
                  key: ValueKey<bool>(obscureText),
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color: const Color(0xFFFF746B),
                  ),
                  splashRadius: 20,
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
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
                return l10n.pleaseEnterPassword;
              }

              return null;
            },
          ),
        ),
      ],
    );
  }

  Column _buildUserNameTextFormFeild(AppLocalizations l10n, bool isRtl) {
    return Column(
      children: [
        Align(
          alignment: isRtl ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 8.0,
              right: isRtl ? 15 : 0,
              left: isRtl ? 0 : 15,
            ),
            child: Text(l10n.phoneNumber,
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
                return l10n.pleaseEnterPhoneNumber;
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
