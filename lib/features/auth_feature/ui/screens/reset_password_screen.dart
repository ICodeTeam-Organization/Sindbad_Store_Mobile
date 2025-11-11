import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/widgets/arrow_back_button_widget.dart';
import 'package:sindbad_management_app/core/widgets/submit_button_widget.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/screens/confirm_password_screen.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/reset_password_cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final confirmPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),
          ArrowBackButtonWidget(),
          SizedBox(
            height: 40,
          ),
          Text(
            'تعيين كلمة مرور جديدة',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text('إنشاء كلمة مرور جديدة لحسابك', style: TextStyle(fontSize: 16)),

          const SizedBox(
            height: 15,
          ),

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
          const SizedBox(height: 20),

          /// NEW PASSWORD
          SubmetButtonWidget(isActive: true, text: "حفظ كلمة المرور"),

          const SizedBox(height: 60),

          // BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          //   listener: (context, state) {
          //     if (state is ResetPasswordLoadSuccess) {
          //       Navigator.pop(context);
          //     }
          //     if (state is ResetPasswordLoadFailure) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         SnackBar(content: Text(state.errorMessage)),
          //       );
          //     }
          //   },
          //   builder: (context, state) {
          //     return StorePrimaryButton(
          //       title: 'تغيير كلمة المرور',
          //       width: MediaQuery.of(context).size.width * 0.9,
          //       height: 50,
          //       isLoading: state is ResetPasswordLoadInProgress,
          //       onTap: () {
          //         if (oldPasswordController.text.isEmpty ||
          //             newPasswordController.text.isEmpty) {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(content: Text("الرجاء ملء جميع الحقول")),
          //           );
          //           return;
          //         }

          //         /// Password rules
          //         if (newPasswordController.text.length < 9 ||
          //             !RegExp(r'^(?=.*[A-Za-z])(?=.*[0-9]).{9,}$')
          //                 .hasMatch(newPasswordController.text)) {
          //           ScaffoldMessenger.of(context).showSnackBar(
          //             const SnackBar(
          //               content: Text(
          //                   "يجب أن تكون كلمة المرور على الأقل 9 حروف، وتحتوي على حرف ورقم."),
          //             ),
          //           );
          //           return;
          //         }

          //         context.read<ResetPasswordCubit>().resetPassword(
          //               oldPasswordController.text,
          //               newPasswordController.text,
          //             );
          //       },
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
