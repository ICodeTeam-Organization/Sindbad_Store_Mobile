import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sindbad_management_app/core/utils/route.dart';

void main() {
  runApp(const SindbadManagementApp());
}

class SindbadManagementApp extends StatelessWidget {
  const SindbadManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 650),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: ThemeData(
          textTheme: GoogleFonts.almaraiTextTheme(
            Theme.of(context).textTheme,
          ),

          scaffoldBackgroundColor:
              const Color(0xFFF9F9F9), // Set default background color
        ),

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AR'), // Arabic, no country code
        ],
        locale: const Locale('ar', 'AR'),
        debugShowCheckedModeBanner: false,

      ),
    );
  }
}
