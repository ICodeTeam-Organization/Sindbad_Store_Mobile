import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          CustomAppBar(tital: 'تغيير كلمة السر', isSearch: false),
          SizedBox(
            height: 40,
          ),
          Text(
            'رقم الموبايل',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('الرجاء ادخال رقم هاتفك للتحقق من حسابك'),
          SizedBox(
            height: 30,
          ),
          _buildUserNameTextFormFeild(),
          SizedBox(
            height: 40,
          ),
          Container(
            width: 380.w,
            height: 47.h,
            decoration: BoxDecoration(
              color: Color(0xffFF746B),
              borderRadius: BorderRadius.circular(10),
            ),
            child: MaterialButton(
              child: Text(
                "ارسال الرمز",
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                // if (_formKey.currentState!.validate()) {
                //   context.read<SignInCubit>().signIn(
                //         phoneNumberController.text,
                //         passwordController.text,
                //       );
                // }
              },
            ),
          )
        ],
      ),
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
            //    controller: phoneNumberController,
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
