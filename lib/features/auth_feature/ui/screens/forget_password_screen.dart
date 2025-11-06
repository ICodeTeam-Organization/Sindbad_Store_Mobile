import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/widgets/arrow_back_button_widget.dart';
import 'package:sindbad_management_app/core/widgets/password_feild_widget.dart';
import 'package:sindbad_management_app/core/widgets/phone_feild_widget.dart';
import 'package:sindbad_management_app/core/widgets/submit_button_widget.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit_state.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool cofirmObscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // important
      body: SingleChildScrollView(
        // The magic happens with these properties
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40,
        ),
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: IntrinsicHeight(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                ArrowBackButtonWidget(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'التحقق من هاتفك',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('الرجاء إدخال رقم هاتفك للتحقق من حسابك'),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      PhoneFeildWidget(
                          phoneNumberController: phoneNumberController),
                      SizedBox(
                        height: 15,
                      ),
                      PasswordFieldWidget(
                        controller: passwordController,
                        label: "كلمة المرور الجديدة",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى إدخال كلمة المرور';
                          }
                          final pattern = RegExp(
                              r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{9,20}$');
                          if (!pattern.hasMatch(value)) {
                            return 'يجب أن تكون كلمة المرور بين 9 و 20 حرفاً، وتحتوي على أحرف وأرقام فقط';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      PasswordFieldWidget(
                        controller: confirmController,
                        label: "تأكيد كلمة المرور",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "يرجى إدخال تأكيد كلمة المرور";
                          }
                          if (value != passwordController.text) {
                            return "كلمة المرور غير متطابقة";
                          }
                          return null;
                        },
                      ),
                      // _buildConfirmPasswordTextFormFeild(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                BlocConsumer<ForgetPasswordCubit, ForgetPasswordCubitState>(
                  builder: (context, state) {
                    if (state is ForgetPasswordLoadInProgress) {
                      return SubmetButtonWidget(
                        isActive: true,
                        text: "ارسال الرمز",
                        isLoading: true,
                      );
                    } else if (state is ForgetPasswordLoadSuccess) {
                      GoRouter.of(context).push(AppRoutes.confirmPassword,
                          extra: phoneNumberController.text);
                    }
                    return SubmetButtonWidget(
                      isActive: true,
                      text: "ارسال الرمز",
                      isLoading: false,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ForgetPasswordCubit>(context)
                              .foregetPassword(phoneNumberController.text,
                                  passwordController.text);
                        }
                      },
                    );
                  },
                  listener: (context, state) {
                    if (state is ForgetPasswordLoadSuccess) {
                      GoRouter.of(context).push(AppRoutes.confirmPassword,
                          extra: phoneNumberController.text);
                    } else if (state is ForgetPasswordLoadFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('حدث خطأ ما. يرجى المحاولة مرة أخرى.')),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
