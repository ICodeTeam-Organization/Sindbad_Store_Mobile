import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/info_row_widget.dart';

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

  List<String> category = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      body: BlocBuilder<GetProfileCubit, GetProfileState>(
          builder: (context, state) {
        if (state is GetProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetProfileFailure) {
          return Center(child: Text(state.error));
        } else if (state is GetProfileSuccess) {
          // You can use state.profileData to access the fetched profile data
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // App Bar

                  const SizedBox(height: 20),

                  // Profile Header Card
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Profile Image and Name
                        CircleAvatar(
                          backgroundColor: Colors.blue[800],
                          radius: 40,
                          child: Text(
                            state.profileModel.userName.isNotEmpty
                                ? state.profileModel.userName[0]
                                : '',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                state.profileModel.userName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Text(
                                ' صاحب متجر',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  const SizedBox(height: 20),

                  // Buttons Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        InfoRow(
                            value: 'رقم الجوال',
                            label: '${state.profileModel.userPhoneNumber}'),
                        InfoRow(
                            value: 'البريد الالكتروني',
                            label: '${state.profileModel.userEmail}'),
                        InfoRow(value: 'الدولة', label: 'السعودية'),
                        _buildActionButton(
                          'تغيير كلمة المرور',
                          () {
                            GoRouter.of(context)
                                .push(AppRouter.storeRouters.kchangePassword);
                          },
                        ),
                        const SizedBox(height: 10),
                        _buildActionButton(
                          'الدفع الآجل الافتراضي',
                          null,
                          switchWidget: Switch.adaptive(
                            activeColor: AppColors.primary,
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                storage.write(
                                    key: 'pay', value: value ? '1' : '2');
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildActionButton(
                          'تسجيل الخروج',
                          () {
                            storage.delete(key: 'token');
                            GoRouter.of(context)
                                .go(AppRouter.storeRouters.signIn);
                          },
                          textColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الفئات',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: category
                              .map((e) => Chip(
                                    label: Text(e),
                                    backgroundColor: Colors.grey[100],
                                    labelStyle: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  Widget _buildActionButton(
    String title,
    Function()? onTap, {
    Color? textColor,
    Widget? switchWidget,
  }) {
    return ListTile(
      leading: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black,
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
                storage.delete(key: 'token');
                GoRouter.of(context).go(AppRoutes.signIn);
              }),
        ),
      ),
      trailing: switchWidget ??
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey[500],
          ),
      onTap: onTap,
    );
  }
}
