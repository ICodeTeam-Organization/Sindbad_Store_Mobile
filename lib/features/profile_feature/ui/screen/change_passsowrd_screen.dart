import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/widgets/store_primary_button.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';
import '../cubit/reset_password_cubit/reset_password_cubit.dart';

class ChangePasssowrdScreen extends StatelessWidget {
  const ChangePasssowrdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 25,
          ),
          CustomAppBar(tital: l10n.changePassword, isSearch: false),
          SizedBox(height: 40),
          CustomTextFormWidget(
            textController: oldPasswordController,
            text: l10n.oldPassword,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          SizedBox(height: 20),
          CustomTextFormWidget(
            textController: newPasswordController,
            text: l10n.newPassword,
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          ),
          SizedBox(height: 20),
          CustomTextFormWidget(
            textController: confirmPasswordController,
            text: l10n.confirmPassword,
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
                  title: l10n.changePassword,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  isLoading: state is ResetPasswordLoadInProgress,
                  onTap: () {
                    if (oldPasswordController.text.isEmpty ||
                        newPasswordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.pleaseFillAllFields)),
                      );
                      return;
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.passwordsDoNotMatch)),
                      );
                      return;
                    } else if (newPasswordController.text.isEmpty ||
                        newPasswordController.text.length < 9 ||
                        !RegExp(r'^(?=.*[A-Za-z])(?=.*[0-9]).{8,}$')
                            .hasMatch(newPasswordController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(l10n.passwordRequirements)),
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
