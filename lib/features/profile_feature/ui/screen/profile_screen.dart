import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/core/dialogs/ErrorDialog.dart';
import 'package:sindbad_management_app/core/dialogs/okey_dialog.dart';
import 'package:sindbad_management_app/core/dialogs/release_dialog_info.dart';
import 'package:sindbad_management_app/core/resources/release.dart';
import 'package:sindbad_management_app/core/services/githubApiservices.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/get_profile_data_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/info_row_widget.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  bool isSwitched = false;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final GitHubApiService gitHubApiService = GitHubApiService();

  List<String> category = [];

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
    context.read<GetProfileCubit>().getProfile();
  }

  Future<void> _loadSwitchState() async {
    final pay = await storage.read(key: 'pay');
    setState(() {
      isSwitched = pay == '1';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  CustomAppBar(tital: "تغيير كلمة المرور", isSearch: false),

      body: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetProfileLoadFailure) {
            return Center(child: Text(state.error));
          } else if (state is GetProfileLoadSuccess) {
            final profile = state.profileModel;

            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    CustomAppBar(tital: 'الملف الشخصي', isSearch: false),

                    const SizedBox(height: 20),
                    // Profile Header
                    _buildTitle(profile),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        // Info Section
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              InfoRow(
                                value: 'رقم الجوال',
                                label: profile.userPhoneNumber,
                              ),
                              InfoRow(
                                value: 'البريد الإلكتروني',
                                label: profile.userEmail,
                              ),
                              const InfoRow(value: 'الدولة', label: 'السعودية'),
                              const SizedBox(height: 10),

                              // Change Password
                              _buildActionButton(
                                'تغيير كلمة المرور',
                                () {
                                  GoRouter.of(context).push(
                                    AppRoutes.changePassword,
                                  );
                                },
                              ),

                              const SizedBox(height: 10),

                              // Pay Later Switch
                              _buildActionButton(
                                'الدفع الآجل الافتراضي',
                                null,
                                switchWidget: Switch.adaptive(
                                  activeColor: AppColors.primary,
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                    });
                                    storage.write(
                                      key: 'pay',
                                      value: value ? '1' : '2',
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(height: 10),
                              //Updates
                              _buildActionButton(
                                'تحميل اخر اصدار',
                                () async {
                                  try {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('جاري التحقق من التحديثات...'),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );

                                    final packageInfo =
                                        await PackageInfo.fromPlatform();
                                    final currentVersion = packageInfo.version;
                                    final isUpdateAvailable =
                                        await gitHubApiService
                                            .isAvailableUpdate(currentVersion);

                                    if (isUpdateAvailable) {
                                      Release _lastRelease =
                                          await gitHubApiService
                                              .getLatestRelease();
                                      showReleaseInfoDialog(context,
                                          release: _lastRelease);
                                    } else {
                                      showOkDialog(
                                        context: context,
                                        title: "تحديث التطبيق",
                                        message:
                                            "لا توجد تحديثات متاحة، أنت تستخدم النسخة الأحدث",
                                      );
                                    }
                                  } catch (e) {
                                    showErrorDialog(
                                      context: context,
                                      title: "خطأ",
                                      description:
                                          "حدث خطأ أثناء التحقق من التحديثات: ${e.toString()}",
                                    );
                                  }
                                },
                                textColor: Colors.red,
                              ),
                              // Logout
                              _buildActionButton(
                                'تسجيل الخروج',
                                () async {
                                  await storage.delete(key: 'token');
                                  if (context.mounted) {
                                    GoRouter.of(context).go(
                                      AppRoutes.signIn,
                                    );
                                  }
                                },
                                textColor: Colors.red,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),

                    // Categories Section
                    _buildCategory(),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Container _buildCategory() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category
                .map(
                  (e) => Chip(
                    label: Text(e),
                    backgroundColor: Colors.grey[100],
                    labelStyle: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Column _buildTitle(GetProfileDataEntity profile) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[800],
          radius: 40,
          child: Text(
            profile.userName.isNotEmpty ? profile.userName[0] : '',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          profile.userName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'صاحب المتجر',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    String title,
    Function()? onTap, {
    Color? textColor,
    Widget? switchWidget,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor ?? Colors.black,
        ),
      ),
      trailing: switchWidget ??
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Colors.grey[500],
          ),
    );
  }
}
