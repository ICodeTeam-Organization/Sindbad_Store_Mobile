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
    context
        .read<GetCategoryNamesCubit>()
        .getMainAndSubCategory(filterType: 1, pageNumber: 1, pageSize: 1000);
    _initApp();
  }

  Future<void> _initApp() async {
    const storage = FlutterSecureStorage();
    bool hasToken = await storage.containsKey(key: 'token') ?? false;

    // Navigate using your Router instead of Navigator 1.0
    if (hasToken) {
      // Example for GoRouter:
      context.go(
        AppRouter.storeRouters.root,
      );
    } else {
      context.go(
        AppRouter.storeRouters.signIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
