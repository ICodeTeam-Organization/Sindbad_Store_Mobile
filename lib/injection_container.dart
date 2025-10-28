import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sindbad_management_app/core/secure_storage.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_soure_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/repository/authentation_repository.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/remote_data/notifiction_remote_data_source.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/repo/notifiction_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/data/data_source/view_product_remote_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/data_source/remote/view_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/View_offer_repo_impl.dart';
import 'features/order_management _features/data/repos_impl/all_order_repo_impl.dart';
import 'features/order_management _features/data/data_sources/all_order_remot_data_source.dart';
import 'features/product_features/add_and_edit_product_feature/data/data_source/add_and_edit_product_to_store_remote_data_source.dart';
import 'features/product_features/view_product_features/data/repos/view_product_store_repo_impl.dart';
import 'features/profile_feature/data/data_source/profile_data_source.dart';
import 'features/profile_feature/data/repo/profile_repo_impl.dart';
import 'core/api_service.dart';

final getit = GetIt.instance;

void initializationContainer() {
  //this is temp for the login cubit to do it correctly
  getit.registerSingleton<ApiService>(ApiService());
  getit.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  //cubits
  //data source
  getit.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  //repositories
  getit.registerSingleton<AuthentationRepository>(
      AuthentationRepositoryImp(getit()));

  //use case
  getit.registerSingleton<SignInUseCase>(SignInUseCase(getit()));

  getit.registerFactory<SignInCubit>(() => SignInCubit(getit()));

  // getit.registerSingleton<AuthentationRepositoryImp>(AuthentationRepositoryImp(
  //     authRemoteDataSource: AuthRemoteDataSourceImpl(
  //   getit.get<ApiService>(),
  //   getit.get<FlutterSecureStorage>(),
  // )));
  getit.registerSingleton<AllOrderRepoImpl>(AllOrderRepoImpl(
    AllOrderRemotDataSourceImpl(
      getit.get<ApiService>(),
      getit.get<FlutterSecureStorage>(),
    ),
  ));
  getit.registerSingleton<ViewProductStoreRepoImpl>(
    ViewProductStoreRepoImpl(
        viewProductRemoteDataSource: ViewProductRemoteDataSourceImpl(
      getit.get<ApiService>(),
      getit.get<FlutterSecureStorage>(),
    )),
  );
  // bagar for add pruduct page
  getit.registerSingleton<AddAndEditProductStoreRepoImpl>(
      AddAndEditProductStoreRepoImpl(
          addAndEditProductToStoreRemoteDataSource:
              AddProductToStoreRemoteDataSourceImpl(
    getit.get<ApiService>(),
    getit.get<FlutterSecureStorage>(),
  )));
  getit.registerSingleton<ViewOfferRepoImpl>(
    ViewOfferRepoImpl(
      ViewOfferRemotDataSourceImpl(
        getit.get<ApiService>(),
        getit.get<FlutterSecureStorage>(),
      ),
    ),
  );
  getit.registerSingleton<NewOfferRepoImpl>(
    NewOfferRepoImpl(
      NewOfferRemotDataSourceImpl(
        getit.get<ApiService>(),
        getit.get<FlutterSecureStorage>(),
      ),
    ),
  );
  getit.registerSingleton<NotifictionRepoImpl>(NotifictionRepoImpl(
      notifictionRemoteDataSource:
          NotifictionRemoteDataSourceImpl(getit.get<ApiService>())));
  getit.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(
      profileDataSource:
          ProfileDataSourceImpl(apiService: getit.get<ApiService>())));
}
