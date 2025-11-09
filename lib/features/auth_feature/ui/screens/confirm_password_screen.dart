import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/widgets/arrow_back_button_widget.dart';
import 'package:sindbad_management_app/core/widgets/submit_button_widget.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/confirm_password_cubit/confirm_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/confirm_password_cubit/confrm_passwrd_states.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit_state.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final String phoneNumber;
  const ConfirmPasswordScreen({super.key, required this.phoneNumber});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  final codeNo1Controller = TextEditingController();
  final codeNo2Controller = TextEditingController();
  final codeNo3Controller = TextEditingController();
  final codeNo4Controller = TextEditingController();
  final codeNo5Controller = TextEditingController();
  final codeNo6Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? _isvalide;
  Timer? _timer;
  int _remainingTime = 60; // Start from 60 seconds
  bool _isButtonActive = true; // Button should be inactive initially

  void _startTimer() {
    // Cancel any existing timer
    _timer?.cancel();

    // Reset timer values
    setState(() {
      _remainingTime = 60;
      _isButtonActive = false;
    });

    // Start new timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
          _isButtonActive = true; // Enable button when timer finishes
        }
      });
    });
  }

  void _resendCode() {
    // This function will be called when user taps the resend button
    _startTimer(); // Restart the timer
    // Add your resend code logic here
  }

  void valdator() {
    if (codeNo1Controller.text.isEmpty ||
        codeNo2Controller.text.isEmpty ||
        codeNo3Controller.text.isEmpty ||
        codeNo4Controller.text.isEmpty ||
        codeNo5Controller.text.isEmpty ||
        codeNo6Controller.text.isEmpty) {
      setState(() {
        _isvalide = false;
      });
    } else {
      setState(() {
        _isvalide = true;
      });
    }
  }

  void _confirmCode() {
    valdator();
    if (_isvalide != null && _isvalide == true) // Only show when not null
    {
      BlocProvider.of<ConfirmPasswordCubit>(context).confirmPassword(
        codeNo1Controller.text,
        codeNo2Controller.text,
        codeNo3Controller.text,
        codeNo4Controller.text,
        codeNo5Controller.text,
        codeNo6Controller.text,
        widget.phoneNumber,
      );
    } else {
      setState(() {
        _isvalide = false;
      });
      // This function will be called when user taps the confirm button
      // Add your confirm code logic here
    }
  }

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start timer when screen initializes
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          ArrowBackButtonWidget(),
          SizedBox(height: 40),
          Text(
            'التحقق من هاتفك',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 30),
          Text('الرجاء إدخال الرمز المكون من 6 أرقام المرسل إلى',
              style: TextStyle(fontSize: 16)),
          Text(
            widget.phoneNumber,
            style: TextStyle(
                color: Color(0xffFF746B),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 50,
                    width: 50.w,
                    child: TextFormField(
                      controller: codeNo1Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                    height: 50,
                    width: 50.w,
                    child: TextFormField(
                      controller: codeNo2Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                    height: 50,
                    width: 50.w,
                    child: TextFormField(
                      controller: codeNo3Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                    height: 50,
                    width: 50.w,
                    child: TextFormField(
                      controller: codeNo4Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                    height: 50,
                    width: 50.w,
                    child: TextFormField(
                      controller: codeNo5Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                    height: 50,
                    width: 50.w,
                    child: TextFormField(
                      controller: codeNo6Controller,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          if (_isvalide != null || _isvalide == false)
            Text(
              "ادخل الرمز المرسل الى هاتفك للمتابعة",
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
          SizedBox(height: 40),
          Text(
            _formatTime(_remainingTime),
            style: TextStyle(
              fontSize: 18,
              color: _remainingTime > 0 ? Colors.grey : Colors.green,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "لم تستلم الرمز؟",
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                onTap: _isButtonActive
                    ? _resendCode
                    : null, // Only allow tap when button is active
                child: Text(
                  ' اعد الارسال',
                  style: TextStyle(
                    color: _isButtonActive ? Color(0xffFF746B) : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          BlocConsumer<ConfirmPasswordCubit, ConfirmPasswordState>(
            builder: (context, state) {
              if (state is ConfirmPasswordLoadInProgress) {
                return SubmetButtonWidget(
                    isActive: true, // Control button state based on timer
                    isLoading: true,
                    text: 'ارسال الرمز',
                    onPressed: null);
              }
              return SubmetButtonWidget(
                  isActive: true, // Control button state based on timer
                  isLoading: false,
                  text: 'ارسال الرمز',
                  onPressed: _confirmCode);
            },
            listener: (context, state) {
              if (state is ConfirmPasswordLoadFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('حدث خطأ ما. يرجى المحاولة مرة أخرى.')),
                );
                // GoRouter.of(context).push(AppRoutes.confirmPassword,
                //     extra: phoneNumberController.text);
              } else if (state is ConfirmPasswordSuccess) {
                ///temp line for testing , this should be deleted when production
                GoRouter.of(context).go(AppRoutes.signIn);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('تمت اعاده ضبط كلمة السر بنجاح')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
