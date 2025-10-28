import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initApp();
    });
  }

  Future<void> _initApp() async {
    const storage = FlutterSecureStorage();
    bool hasToken = await storage.containsKey(key: 'token');

    //await Future.delayed(const Duration(seconds: 100));

    if (mounted) {
      if (hasToken) {
        context.go(AppRoutes.root);
      } else {
        context.go(AppRoutes.signIn);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F4), // solid background color
      body: SafeArea(
        child: Stack(
          children: [
            // Center content (image + text)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 176,
                    width: 176,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70)),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset(
                        'assets/splahs_screen_loading.png',
                        width: 50,
                        height: 100.65,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'مالك المحل',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333), // dark text for contrast
                    ),
                  ),
                ],
              ),
            ),

            // Progress indicator at bottom
            const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: CircularProgressIndicator(
                  color: Color(0xFF333333),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
