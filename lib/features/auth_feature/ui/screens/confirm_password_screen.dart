import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/widgets/arrow_back_button_widget.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  final String phoneNumber;
  const ConfirmPasswordScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
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
            'التحقق من هاتفك',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text('الرجاء إدخال الرمز المكون من 4 أرقام المرسل إلى',
              style: TextStyle(fontSize: 16)),
          Text(
            phoneNumber,
            style: TextStyle(
                color: Color(0xffFF746B),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  height: 50,
                  width: 50.w,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                  )),
              SizedBox(height: 50, width: 50.w, child: TextFormField()),
              SizedBox(height: 50, width: 50.w, child: TextFormField()),
              SizedBox(height: 50, width: 50.w, child: TextFormField()),
              SizedBox(height: 50, width: 50.w, child: TextFormField()),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Text("00:59", style: TextStyle(fontSize: 18)),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "لم تستلم الرمز؟",
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: () {
                  // إعادة إرسال الرمز
                },
                child: Text(
                  ' اعد الارسال',
                  style: TextStyle(
                      color: Color(0xffFF746B), fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SubmetButtonWidget(
            isActive: true,
            text: 'ارسال الرمز',
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

class SubmetButtonWidget extends StatelessWidget {
  final bool isActive;
  final VoidCallback? onPressed;
  final String text;

  const SubmetButtonWidget({
    super.key,
    required this.isActive,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      height: 47.h,
      decoration: BoxDecoration(
        color: !isActive
            ? Color(0xffffffff)
            : Color(0xffFF746B), //Color(0xffFF746B),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Color(0xffffffff) : Color(0xff636773),
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: isActive ? onPressed : null,
      ),
    );
  }
}
