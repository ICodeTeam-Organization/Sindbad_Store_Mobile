import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';
import '../cubit/reset_password_cubit/reset_password_cubit.dart';

class ChangePasssowrdScreen extends StatelessWidget {
  const ChangePasssowrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          CustomAppBar(tital: "تغيير كلمة المرور", isSearch: false),
          SizedBox(height: 40),
          CustomTextFormWidget(
            textController: oldPasswordController,
            text: "كلمة المرور القديمة",
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          SizedBox(height: 20),
          CustomTextFormWidget(
            textController: newPasswordController,
            text: "كلمة المرور الجديدة",
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          SizedBox(height: 20),
          CustomTextFormWidget(
            textController: confirmPasswordController,
            text: "تاكيد كلمة المرور",
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          SizedBox(height: 60),
          BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordLoadSuccess) {
                Navigator.pop(context);
              }
              if (state is ResetPasswordLoadFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }
            },
            builder: (context, state) {
              return StorePrimaryButton(
                  title: 'تغيير كلمة المرور',
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  isLoading: state is ResetPasswordLoadInProgress,
                  onTap: () {
                    if (oldPasswordController.text.isEmpty ||
                        newPasswordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("الرجاء ملء جميع الحقول")),
                      );
                      return;
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("كلمة المرور غير متطابقة")),
                      );
                      return;
                    } else if (newPasswordController.text.isEmpty ||
                        newPasswordController.text.length < 9 ||
                        !RegExp(r'^(?=.*[A-Za-z])(?=.*[0-9]).{8,}$')
                            .hasMatch(newPasswordController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "يجب أن تكون كلمة المرور على الأقل 9 حروف، ويجب أن تحتوي على حرف واحد على الأقل و رقم واحد على الأقل")),
                      );
                    }
                    context.read<ResetPasswordCubit>().resetPassword(
                          oldPasswordController.text,
                          newPasswordController.text,
                        );
                  });
            },
          )
        ],
      ),
    );
  }
}
