import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sindbad_management_app/core/resources/release.dart';
import 'package:sindbad_management_app/core/services/githubApiservices.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/get_profile_data_entity.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/get_profile_data_usecase.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/logout_use_case.dart';

part 'drawer_state.dart';

/// Cubit to manage Drawer-specific state: profile data and logout.
/// Data is stored as a property, accessed via context.watch<DrawerCubit>().
/// State only represents loading status (Initial, Loading, Loaded, Error).
class DrawerCubit extends Cubit<DrawerState> {
  final GetProfileDataUsecase _getProfileUsecase;
  final LogoutUseCase _logoutUseCase;
  final GitHubApiService _gitHubApiService;

  // Profile data stored as property - accessed via context.watch
  GetProfileDataEntity? profile;

  // Latest release data stored as property - accessed via context.watch
  Release? latestRelease;
  bool? isUpdateAvailable;
  String? currentVersion;

  DrawerCubit(
    this._getProfileUsecase,
    this._logoutUseCase,
    this._gitHubApiService,
  ) : super(DrawerInitial());

  /// Loads profile data from API.
  Future<void> loadProfile() async {
    emit(DrawerLoading());
    // Load current app version
    final packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;

    final result = await _getProfileUsecase.execute();
    result.fold(
      (failure) => emit(DrawerError(failure.message)),
      (profileData) {
        profile = profileData;
        emit(DrawerLoaded());
      },
    );
  }

  /// Logs out the user and clears data.
  Future<void> logout() async {
    emit(DrawerLoading());
    final result = await _logoutUseCase.execute();
    result.fold(
      (failure) => emit(DrawerError(failure.message!)),
      (_) {
        profile = null;
        emit(DrawerLoggedOut());
      },
    );
  }

  /// Checks for app updates and stores result in latestRelease property.
  Future<void> checkForUpdate() async {
    emit(DrawerLoading());
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      currentVersion = packageInfo.version;
      isUpdateAvailable =
          await _gitHubApiService.isAvailableUpdate(currentVersion!);

      if (isUpdateAvailable == true) {
        latestRelease = await _gitHubApiService.getLatestRelease();
      } else {
        latestRelease = null;
      }
      emit(DrawerLoaded());
    } catch (e) {
      emit(DrawerError(e.toString()));
    }
  }
}
