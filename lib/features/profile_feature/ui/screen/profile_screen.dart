import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/dialogs/ErrorDialog.dart';
import 'package:sindbad_management_app/core/dialogs/okey_dialog.dart';
import 'package:sindbad_management_app/core/dialogs/release_dialog_info.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/drawer_cubit/drawer_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/info_row_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/setting_cubit/app_settings_cubit.dart';
import 'package:sindbad_management_app/injection_container.dart';

/// A drawer widget that displays the full profile content.
/// This drawer is accessible from anywhere in the app via the person icon.
class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({super.key});

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  late DrawerCubit _drawerCubit;

  @override
  void initState() {
    super.initState();
    _drawerCubit = getit<DrawerCubit>();
    _drawerCubit.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<DrawerCubit, DrawerState>(
      bloc: _drawerCubit,
      listener: (context, state) {
        // Handle update check results
        if (state is DrawerLoadInProgress &&
            _drawerCubit.isUpdateAvailable != null) {
          if (_drawerCubit.isUpdateAvailable == true &&
              _drawerCubit.latestRelease != null) {
            showReleaseInfoDialog(context,
                release: _drawerCubit.latestRelease!);
          } else if (_drawerCubit.isUpdateAvailable == false) {
            showOkDialog(
              context: context,
              title: l10n.appUpdate,
              message: l10n.noUpdatesAvailable,
            );
          }
          // Reset the flag after handling
          _drawerCubit.isUpdateAvailable = null;
        } else if (state is DrawerLoadFailure &&
            _drawerCubit.isUpdateAvailable != null) {
          showErrorDialog(
            context: context,
            title: l10n.error,
            description: "${l10n.errorCheckingUpdates}: ${state.message}",
          );
          _drawerCubit.isUpdateAvailable = null;
        }
      },
      child: Drawer(
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
                      BlocBuilder<SettingsCubit, SettingsState>(
                        bloc: getit<SettingsCubit>(),
                        builder: (context, state) {
                          final cubit = getit<SettingsCubit>();
                          return _buildActionButton(
                            l10n.defaultDeferredPayment,
                            null,
                            switchWidget: Switch.adaptive(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: cubit.isPayLaterEnabled,
                              onChanged: _togglePayMethod,
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 10),

                      // Dark Mode Switch
                      BlocBuilder<SettingsCubit, SettingsState>(
                        bloc: getit<SettingsCubit>(),
                        builder: (context, state) {
                          final cubit = getit<SettingsCubit>();
                          return _buildActionButton(
                            l10n.darkMode,
                            null,
                            switchWidget: Switch.adaptive(
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              value: cubit.isDarkMode,
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
                          value: getit<SettingsCubit>().localeCode,
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
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.checkingForUpdates),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          _drawerCubit.checkForUpdate();
                        },
                        textColor: Colors.red,
                      ),

                      // Logout
                      _buildActionButton(
                        l10n.logout,
                        () async {
                          await getit<SettingsCubit>().clearAllSettings();
                          _drawerCubit.logout();

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

                // App Version
                BlocBuilder<DrawerCubit, DrawerState>(
                  bloc: _drawerCubit,
                  builder: (context, state) {
                    return Text(
                      'v${_drawerCubit.currentVersion ?? '...'}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color
                            ?.withOpacity(0.6),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggleLocalsMethod(value) {
    if (value != null) {
      getit<SettingsCubit>().setLocale(Locale(value));
      setState(() {});
    }
  }

  void _toggleThemMethod(value) {
    getit<SettingsCubit>().toggleTheme();
  }

  void _togglePayMethod(value) {
    getit<SettingsCubit>().togglePayLater();
  }

  Widget _buildInfoRow(String label) {
    return BlocBuilder<DrawerCubit, DrawerState>(
      bloc: _drawerCubit,
      builder: (context, state) {
        if (state is DrawerLoadInProgress) {
          return InfoRow(
            value: label,
            label: _drawerCubit.profile?.userPhoneNumber ?? "",
          );
        } else if (state is DrawerLoadInProgress) {
          return InfoRow(
            isLoading: true,
            value: label,
            label: "",
          );
        } else if (state is DrawerLoadFailure) {
          return InfoRow(
            value: label,
            label: state.message,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildEmailRow(AppLocalizations l10n) {
    return BlocBuilder<DrawerCubit, DrawerState>(
      bloc: _drawerCubit,
      builder: (context, state) {
        if (state is DrawerLoadInProgress) {
          return InfoRow(
            value: l10n.email,
            label: _drawerCubit.profile?.userEmail ?? "",
          );
        } else if (state is DrawerLoadInProgress) {
          return InfoRow(
            isLoading: true,
            value: l10n.email,
            label: "",
          );
        } else if (state is DrawerLoadFailure) {
          return InfoRow(
            value: l10n.email,
            label: state.message,
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCountryRow(AppLocalizations l10n) {
    return BlocBuilder<DrawerCubit, DrawerState>(
      bloc: _drawerCubit,
      builder: (context, state) {
        if (state is DrawerLoadInProgress) {
          return InfoRow(
            value: l10n.country,
            label:
                _drawerCubit.profile?.userCuntry == 1 ? l10n.saudiArabia : "",
          );
        } else if (state is DrawerLoadInProgress) {
          return InfoRow(
            isLoading: true,
            value: l10n.country,
            label: "",
          );
        } else if (state is DrawerLoadFailure) {
          return InfoRow(
            value: l10n.country,
            label: state.message,
          );
        }
        return const SizedBox();
      },
    );
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
            children: (_drawerCubit.profile?.userCategory ?? [])
                .map(
                  (e) => Chip(
                    label: Text(e.toString()),
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

  Widget _buildTitle(AppLocalizations l10n) {
    return BlocBuilder<DrawerCubit, DrawerState>(
      bloc: _drawerCubit,
      builder: (context, state) {
        final userName = _drawerCubit.profile?.userName ?? '';

        return Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue[800],
              radius: 50,
              child: state is DrawerLoadInProgress
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
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
      },
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
