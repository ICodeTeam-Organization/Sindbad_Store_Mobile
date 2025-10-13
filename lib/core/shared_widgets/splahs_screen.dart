import 'dart:ffi';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/screens/login.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/root.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //since here eaf the categories ftom the API amd store them in the local
    //storage,
    context.read<GetCategoryNamesCubit>().getMainAndSubCategory();

    // Wait until the widget is mounted and built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    //this method fethc the token from the local storage and if exisit
    // nagivate the user to the Root widget, else it nagive the user to the
    //login mehtod
    const storage = FlutterSecureStorage();
    bool hasToken = await storage.containsKey(key: 'token') ?? false;
    // await Future.delayed(Duration(seconds: 10));
    if (mounted) {
      if (hasToken) {
        context.go(AppRouter.storeRouters.root);
      } else {
        context.go(AppRouter.storeRouters.signIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF746B),
      body: SafeArea(
        child: Stack(
          children: [
            // Centered content (image + text)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Replace with your asset path
                  Image.asset(
                    'assets/splahs_screen.png',
                    width: 180,
                    height: 180,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'مالك المحل',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            // Progress indicator at bottom center
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
