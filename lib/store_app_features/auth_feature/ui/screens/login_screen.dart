import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/core/widgets/custom_primary_button_widget.dart';
import 'package:sindbad_management_app/store_app_features/auth_feature/ui/widgets/auth_text_Field_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  

  @override
Widget build(BuildContext context) {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  
  /// function to change into an app for now 
  void login() {
    String phoneInput = phoneController.text;

    // Validate the phone input (you can add more validation logic here)
    if (phoneInput.isNotEmpty) {
      if (phoneInput == "123") {
        GoRouter.of(context).push(AppRouter.storeRouters.kStoreHome);

      }
    }
  }

  var media = MediaQuery.of(context).size.width;
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 6.0.w),
              child: Text(
                'تسجيل الدخول',
                style: KTextStyle.primaryTitle,
                // style: TextStyle(
                //   fontSize: 22.sp,
                //   fontWeight: FontWeight.bold
                // ),
              ),
            ),
          ),
          SizedBox(height: 80.0.h),
          CustomTextFieldWidget(
            labelText: "رقم الجوال :",
            textInputType: TextInputType.number,
            controller: phoneController,
          ),
          SizedBox(height: 16.0.h),
          CustomTextFieldWidget(
            labelText: "كلمة المرور :",
            textInputType: TextInputType.number,
            controller: passwordController,
          ),
          SizedBox(height: 50.0.h),
          KCustomPrimaryButtonWidget(
            buttonName: "تسجيل الدخول",
            width: (media - 70).w,
            height: 40.0.h,
            onPressed: () {
              login();
              // Navigator.pushNamed(context, '/home');
            },
          )
        ],
      ),
    ),
  );
}
  
}
