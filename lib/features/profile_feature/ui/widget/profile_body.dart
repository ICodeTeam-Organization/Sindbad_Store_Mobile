import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/shared_widgets/dialogs/confirm_dialog.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/routers/route.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/profile_button_widget.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool isSwitched = false;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    storage.read(key: 'pay').then((value) {
      setState(() {
        isSwitched = value == '1';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                tital: "الملف الشخصي",
                isSearch: false,
              ),
              CircleAvatar(
                backgroundColor: Colors.redAccent,
                child: Text(
                  'S',
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                radius: 50,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Sindbad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'sindbad@gmail.com',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '0123456789',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              ProfileButton(
                  title: 'تغيير كلمة المرور',
                  icon: Icons.lock,
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.changePassword);
                  }),
              SizedBox(
                height: 10,
              ),
              ProfileButton(
                  title: 'الدفع الاجل الافتراضي',
                  icon: Icons.payment,
                  switchButtton: Switch.adaptive(
                      activeColor: AppColors.primary,
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          storage.write(key: 'pay', value: value ? '1' : '2');
                        });
                      }),
                  onTap: null),
              SizedBox(
                height: 10,
              ),
              ProfileButton(
                  title: ' تسجيل الخروج',
                  icon: Icons.logout,
                  onTap: () {
                    showConfirmDialog(
                            context: context,
                            title: "تسجيل الخروج",
                            message: "هل انت متأكد من تسجيل الخروج؟")
                        .then((confirmed) {
                      if (confirmed ?? false) {
                        storage.delete(key: 'token');
                        GoRouter.of(context).go(AppRoutes.signIn);
                      }
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
