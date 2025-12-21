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
import 'package:sindbad_management_app/features/profile_feature/domin/entity/get_profile_data_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/info_row_widget.dart';
import 'package:sindbad_management_app/core/cubit/app_settings_cubit.dart';
import 'package:sindbad_management_app/injection_container.dart';

/// A drawer widget that displays the full profile content.
/// This drawer is accessible from anywhere in the app via the person icon.
class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({super.key});

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  bool isSwitched = false;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final GitHubApiService gitHubApiService = GitHubApiService();

  GetProfileDataEntity profile = GetProfileDataEntity(
      userEmail: '',
      userName: '',
      userPhoneNumber: '',
      userCuntry: 4,
      userCategory: []);
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
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with close button
              // Container(
              //   padding: const EdgeInsets.all(16),
              //   color: Theme.of(context).primaryColor,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'الملف الشخصي',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 20,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       IconButton(
              //         icon: Icon(Icons.close, color: Colors.white),
              //         onPressed: () => Navigator.pop(context),
              //       ),
              //     ],
              //   ),
              // ),

              const SizedBox(height: 20),

              // Profile Title
              _buildTitle(),

              const SizedBox(height: 20),

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
                    // Phone Number
                    _buildInfoRow('رقم الجوال'),

                    // Email
                    _buildEmailRow(),

                    // Country
                    _buildCountryRow(),

                    const SizedBox(height: 10),

                    // Change Password
                    _buildActionButton(
                      'تغيير كلمة المرور',
                      () {
                        Navigator.pop(context);
                        GoRouter.of(context).push(AppRoutes.changePassword);
                      },
                    ),

                    // Add Products via Excel
                    _buildActionButton(
                      'اضافة المنتجات عبر الاكسيل',
                      () {
                        Navigator.pop(context);
                        GoRouter.of(context).push(AppRoutes.addExcelPage);
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

                    // Dark Mode Switch
                    BlocBuilder<AppSettingsCubit, AppSettingsState>(
                      bloc: getit<AppSettingsCubit>(),
                      builder: (context, settingsState) {
                        return _buildActionButton(
                          'الوضع الليلي',
                          null,
                          switchWidget: Switch.adaptive(
                            activeColor: AppColors.primary,
                            value: settingsState.themeMode == ThemeMode.dark,
                            onChanged: (value) {
                              getit<AppSettingsCubit>().toggleTheme();
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // Language Dropdown
                    _buildActionButton(
                      'اللغة',
                      null,
                      switchWidget: DropdownButton<String>(
                        value: getit<AppSettingsCubit>().localeCode,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down),
                        items: const [
                          DropdownMenuItem(
                            value: 'ar',
                            child: Text('العربية'),
                          ),
                          DropdownMenuItem(
                            value: 'en',
                            child: Text('English'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            getit<AppSettingsCubit>().setLocale(Locale(value));
                            setState(() {});
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Download Latest Version
                    _buildActionButton(
                      'تحميل اخر اصدار',
                      () async {
                        try {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('جاري التحقق من التحديثات...'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          final packageInfo = await PackageInfo.fromPlatform();
                          final currentVersion = packageInfo.version;
                          final isUpdateAvailable = await gitHubApiService
                              .isAvailableUpdate(currentVersion);

                          if (isUpdateAvailable) {
                            Release lastRelease =
                                await gitHubApiService.getLatestRelease();
                            if (context.mounted) {
                              showReleaseInfoDialog(context,
                                  release: lastRelease);
                            }
                          } else {
                            if (context.mounted) {
                              showOkDialog(
                                context: context,
                                title: "تحديث التطبيق",
                                message:
                                    "لا توجد تحديثات متاحة، أنت تستخدم النسخة الأحدث",
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showErrorDialog(
                              context: context,
                              title: "خطأ",
                              description:
                                  "حدث خطأ أثناء التحقق من التحديثات: ${e.toString()}",
                            );
                          }
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
                          Navigator.pop(context);
                          GoRouter.of(context).go(AppRoutes.signIn);
                        }
                      },
                      textColor: Colors.red,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Categories Section
              _buildCategory(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label) {
    final state = context.watch<GetProfileCubit>().state;
    if (state is GetProfileLoadSuccess) {
      return InfoRow(
        value: label,
        label: state.profileModel.userPhoneNumber,
      );
    } else if (state is GetProfileLoadInProgress) {
      return InfoRow(
        isLoading: true,
        value: label,
        label: "",
      );
    } else if (state is GetProfileLoadFailure) {
      return InfoRow(
        value: label,
        label: state.error,
      );
    }
    return const SizedBox();
  }

  Widget _buildEmailRow() {
    final state = context.watch<GetProfileCubit>().state;
    if (state is GetProfileLoadSuccess) {
      return InfoRow(
        value: 'البريد الإلكتروني',
        label: state.profileModel.userEmail,
      );
    } else if (state is GetProfileLoadInProgress) {
      return InfoRow(
        isLoading: true,
        value: 'البريد الإلكتروني',
        label: "",
      );
    } else if (state is GetProfileLoadFailure) {
      return InfoRow(
        value: 'البريد الإلكتروني',
        label: state.error,
      );
    }
    return const SizedBox();
  }

  Widget _buildCountryRow() {
    final state = context.watch<GetProfileCubit>().state;
    if (state is GetProfileLoadSuccess) {
      return InfoRow(
        value: 'الدولة',
        label: state.profileModel.userCuntry == 1 ? "السعودية" : "",
      );
    } else if (state is GetProfileLoadInProgress) {
      return InfoRow(
        isLoading: true,
        value: 'الدولة',
        label: "",
      );
    } else if (state is GetProfileLoadFailure) {
      return InfoRow(
        value: 'الدولة',
        label: state.error,
      );
    }
    return const SizedBox();
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

  Column _buildTitle() {
    final state = context.watch<GetProfileCubit>().state;
    String userName = '';
    if (state is GetProfileLoadSuccess) {
      userName = state.profileModel.userName;
    }

    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.blue[800],
          radius: 40,
          child: Text(
            userName.isNotEmpty ? userName[0] : '',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          userName,
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
