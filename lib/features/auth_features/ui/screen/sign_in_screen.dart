import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/features/auth_features/ui/widget/text_form.dart';

import '../../../../core/setup_service_locator.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import '../../../../core/utils/route.dart';
import '../../data/repos_impl/sign_in_repo_impl.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../manager/cubit/sign_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    @override
    void dispose() {
      super.dispose();
      phoneController.dispose();
      passwordController.dispose();
    }

    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SignInCubit(
            SignInUseCase(
              getit.get<SignInRepoImpl>(),
            ),
          ),
          child: Container(
            color: Color(0xffF6F5F6),
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     fit: BoxFit.fill,
            //     image: AssetImage('assetName'),
            //   ),
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('مرحبا',
                    style: KTextStyle.primaryTitle
                        .copyWith(color: AppColors.colorButton)),
                Text('يرجى تسجيل الدخول الى محلك',
                    style: KTextStyle.textStyle14),
                TextForm(
                  labelText: 'رقم الجوال',
                  controller: phoneController,
                  textInputType: TextInputType.number,
                ),
                TextForm(
                  labelText: 'كلمة السر',
                  controller: passwordController,
                  textInputType: TextInputType.number,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Center(
                  child: BlocConsumer<SignInCubit, SignInState>(
                    listener: (context, state) {
                      if (state is SignInFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(state.errorMessage.toString())),
                        );
                        print(state.errorMessage);
                      } else if (state is SignInSuccess) {
                        if (state.user.userRoles[0] == 'Store') {
                          context.push(AppRouter.storeRouters.root);
                          phoneController.clear();
                          passwordController.clear();
                        }
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () async {
                          await context.read<SignInCubit>().signIn(
                                phoneController.text,
                                passwordController.text,
                              );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 370.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: AppColors.colorButton,
                            borderRadius: BorderRadiusDirectional.circular(8),
                          ),
                          child: Text("تسجيل الدخول",
                              style: KTextStyle.textStyle14
                                  .copyWith(color: Colors.white)),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import '../../../../core/setup_service_locator.dart';
// import '../../../../core/styles/text_style.dart';
// import '../../../../core/utils/route.dart';
// import '../../../../core/widgets/custom_primary_button_widget.dart';
// import '../../data/repos_impl/sign_in_repo_impl.dart';
// import '../../domain/usecases/sign_in_usecase.dart';
// import '../manager/cubit/sign_in_cubit.dart';
// import '../widget/text_form.dart';

// class SignInScreen extends StatefulWidget {
//   const SignInScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<SignInScreen> {
//   // Controllers
//   final phoneNumberController = TextEditingController();
//   final passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   phoneNumberController.dispose();
  //   passwordController.dispose();
  // }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SingleChildScrollView(
//           child: BlocProvider(
        // create: (context) =>
        //     SignInCubit(SignInUseCase(getit.get<SignInRepoImpl>())),
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 100.0.h, horizontal: 16.0.w),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: EdgeInsets.only(right: 6.0.w),
//                   child: Text(
//                     'تسجيل الدخول',
//                     style: KTextStyle.primaryTitle,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 50.0.h),
//               TextForm(
//                 labelText: "رقم الجوال :",
//                 textInputType: TextInputType.phone,
//                 controller: phoneNumberController,
//               ),
//               // SizedBox(height: 16.0.h),
//               TextForm(
//                 labelText: "كلمة المرور :",
//                 textInputType: TextInputType.visiblePassword,
//                 controller: passwordController,
//               ),
//               SizedBox(height: 20.0.h),

//               BlocConsumer<SignInCubit, SignInState>(
//                 listener: (context, state) {
                  // if (state is SignInFailure) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text(state.errorMessage.toString())),
                  //   );
                  //   print(state.errorMessage);
                  // } else if (state is SignInSuccess) {
                  //   if (state.user.userRoles[0] == 'Store') {
                  //     context.push(AppRouter.storeRouters.order);
                  //     phoneNumberController.clear();
                  //     passwordController.clear();
                  //   }
                  // }
                // },
//                 builder: (context, state) {
//                   return KCustomPrimaryButtonWidget(
//                     buttonName: "تسجيل الدخول",
//                     width: (media - 70).w,
//                     height: 40.0.h,
//                     onPressed: () async {
                      // await context.read<SignInCubit>().signIn(
                      //       phoneNumberController.text,
                      //       passwordController.text,
                      //     );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
