import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
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
    context.read<ProfileCubit>().getProfile();
  }

  Future<void> _loadSwitchState() async {
    final pay = await storage.read(key: 'pay');
    setState(() {
      isSwitched = pay == '1';
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Profile Title
              _buildTitle(l10n),

              const SizedBox(height: 20),

              // Info Section
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Phone Number
                    _buildInfoRow(l10n.phoneNumber),

                    // Email
                    _buildEmailRow(l10n),

                    // Country
                    _buildCountryRow(l10n),

                    const SizedBox(height: 10),

                    // Change Password
                    _buildActionButton(
                      l10n.changePassword,
                      () {
                        Navigator.pop(context);
                        GoRouter.of(context).push(AppRoutes.changePassword);
                      },
                    ),

                    // Add Products via Excel
                    _buildActionButton(
                      l10n.addProductsViaExcel,
                      () {
                        Navigator.pop(context);
                        GoRouter.of(context).push(AppRoutes.addExcelPage);
                      },
                    ),

                    const SizedBox(height: 10),

                    // Pay Later Switch
                    _buildActionButton(
                      l10n.defaultDeferredPayment,
                      null,
                      switchWidget: Switch.adaptive(
                        activeColor: AppColors.primary,
                        value: isSwitched,
                        onChanged: _togglePayMethod,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Dark Mode Switch
                    BlocBuilder<AppSettingsCubit, AppSettingsState>(
                      bloc: getit<AppSettingsCubit>(),
                      builder: (context, settingsState) {
                        return _buildActionButton(
                          l10n.darkMode,
                          null,
                          switchWidget: Switch.adaptive(
                            activeColor: AppColors.primary,
                            value: settingsState.themeMode == ThemeMode.dark,
                            onChanged: _toggleThemMethod,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 10),

                    // Language Dropdown
                    _buildActionButton(
                      l10n.language,
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
                        onChanged: _toggleLocalsMethod,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Download Latest Version
                    _buildActionButton(
                      l10n.downloadLatestVersion,
                      () async {
                        try {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.checkingForUpdates),
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
                                title: l10n.appUpdate,
                                message: l10n.noUpdatesAvailable,
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            showErrorDialog(
                              context: context,
                              title: l10n.error,
                              description:
                                  "${l10n.errorCheckingUpdates}: ${e.toString()}",
                            );
                          }
                        }
                      },
                      textColor: Colors.red,
                    ),

                    // Logout
                    _buildActionButton(
                      l10n.logout,
                      () async {
                        context.read<ProfileCubit>().logout();

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
              _buildCategory(l10n),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleLocalsMethod(value) {
    if (value != null) {
      getit<AppSettingsCubit>().setLocale(Locale(value));
      setState(() {});
    }
  }

  void _toggleThemMethod(value) {
    getit<AppSettingsCubit>().toggleTheme();
  }

  void _togglePayMethod(value) {
    setState(() {
      isSwitched = value;
    });
    storage.write(
      key: 'pay',
      value: value ? '1' : '2',
    );
  }

  Widget _buildInfoRow(String label) {
    final state = context.watch<ProfileCubit>().state;
    if (state is GetProfileLoadSuccess) {
      return InfoRow(
        value: label,
        label: state.profileModel?.userPhoneNumber ?? "",
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

  Widget _buildEmailRow(AppLocalizations l10n) {
    final state = context.watch<ProfileCubit>().state;
    if (state is GetProfileLoadSuccess) {
      return InfoRow(
        value: l10n.email,
        label: state.profileModel?.userEmail ?? "",
      );
    } else if (state is GetProfileLoadInProgress) {
      return InfoRow(
        isLoading: true,
        value: l10n.email,
        label: "",
      );
    } else if (state is GetProfileLoadFailure) {
      return InfoRow(
        value: l10n.email,
        label: state.error,
      );
    }
    return const SizedBox();
  }

  Widget _buildCountryRow(AppLocalizations l10n) {
    final state = context.watch<ProfileCubit>().state;
    if (state is GetProfileLoadSuccess) {
      return InfoRow(
        value: l10n.country,
        label: state.profileModel?.userCuntry == 1 ? l10n.saudiArabia : "",
      );
    } else if (state is GetProfileLoadInProgress) {
      return InfoRow(
        isLoading: true,
        value: l10n.country,
        label: "",
      );
    } else if (state is GetProfileLoadFailure) {
      return InfoRow(
        value: l10n.country,
        label: state.error,
      );
    }
    return const SizedBox();
  }

  Container _buildCategory(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              l10n.categories,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
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
                    backgroundColor:
                        Theme.of(context).chipTheme.backgroundColor,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Column _buildTitle(AppLocalizations l10n) {
    final state = context.watch<ProfileCubit>().state;
    String userName = '';
    if (state is GetProfileLoadSuccess) {
      userName = state.profileModel?.userName ?? "";
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
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.titleLarge?.color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.storeOwner,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodySmall?.color,
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
          color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing: switchWidget ??
          Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
          ),
    );
  }
}
