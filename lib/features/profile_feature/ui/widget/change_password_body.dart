import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';

class ChangePasswordBody extends StatelessWidget {
  const ChangePasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
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
          StorePrimaryButton(
            title: 'تغيير كلمة المرور',
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
          )
        ],
      ),
    );
  }
}
