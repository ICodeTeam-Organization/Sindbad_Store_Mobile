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
import 'package:sindbad_management_app/features/order_management%20_features/domain/repos/all_order_repo.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/all_order_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/data/data_source/view_product_remote_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/data_source/remote/view_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/View_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/repos/view_product_store_repo.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/use_cases/get_products_by_filter_use_case.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'features/order_management _features/data/repos_impl/all_order_repo_impl.dart';
import 'features/order_management _features/data/data_sources/all_order_remot_data_source.dart';
import 'features/product_features/add_and_edit_product_feature/data/data_source/add_and_edit_product_to_store_remote_data_source.dart';
import 'features/product_features/view_product_features/data/repos/view_product_store_repo_impl.dart';
import 'features/profile_feature/data/data_source/profile_data_source.dart';
import 'features/profile_feature/data/repo/profile_repo_impl.dart';
import 'core/api_service.dart';

final getit = GetIt.instance;

void initializationContainer() {
  // ----------------
  //  Services
  // ----------------
  getit.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  getit.registerSingleton<ApiService>(ApiService());

  // ----------------
  //  Data Sources
  // ----------------
  getit.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  getit.registerSingleton<AllOrderRemotDataSource>(
      AllOrderRemotDataSourceImpl(getit(), getit()));
  getit.registerSingleton<ViewProductRemoteDataSource>(
      ViewProductRemoteDataSourceImpl(getit(), getit()));
  // ----------------
  //  Repositories
  // ----------------
  getit.registerSingleton<AuthentationRepository>(
      AuthentationRepositoryImp(getit()));

  getit.registerSingleton<AllOrderRepo>(AllOrderRepoImpl(getit()));
  getit.registerSingleton<ViewProductRepoImpl>(ViewProductRepoImpl(getit()));

  // ----------------
  //  Use Cases
  // ----------------
  getit.registerSingleton<SignInUseCase>(SignInUseCase(getit()));
  getit.registerSingleton<AllOrderUsecase>(AllOrderUsecase(getit()));
  getit.registerSingleton<GetProductsByFilterUseCase>(
      GetProductsByFilterUseCase(getit()));

  // ----------------
  //  Cubits
  // ----------------
  getit.registerFactory<SignInCubit>(() => SignInCubit(getit()));
  getit.registerFactory<AllOrderCubit>(() => AllOrderCubit(getit()));
  getit.registerFactory<GetStoreProductsWithFilterCubit>(
      () => GetStoreProductsWithFilterCubit(getit()));

  // getit.registerSingleton<AuthentationRepositoryImp>(AuthentationRepositoryImp(
  //     authRemoteDataSource: AuthRemoteDataSourceImpl(
  //   getit.get<ApiService>(),
  //   getit.get<FlutterSecureStorage>(),
  // )));
  // getit.registerSingleton<AllOrderRepoImpl>(AllOrderRepoImpl(
  //   AllOrderRemotDataSourceImpl(
  //     getit.get<ApiService>(),
  //     getit.get<FlutterSecureStorage>(),
  //   ),
  // ));
  ///////
  // getit.registerSingleton<ViewProductStoreRepoImpl>(
  //   ViewProductStoreRepoImpl(
  //           ViewProductRemoteDataSourceImpl(getit(), getit())),
  // );

  // bagar for add pruduct page
  getit.registerSingleton<AddAndEditProductStoreRepoImpl>(
      AddAndEditProductStoreRepoImpl(
          addAndEditProductToStoreRemoteDataSource:
              AddProductToStoreRemoteDataSourceImpl(getit(), getit())));
  getit.registerSingleton<ViewOfferRepoImpl>(
    ViewOfferRepoImpl(
      ViewOfferRemotDataSourceImpl(getit(), getit()),
    ),
  );
  getit.registerSingleton<NewOfferRepoImpl>(
    NewOfferRepoImpl(
      NewOfferRemotDataSourceImpl(getit(), getit()),
    ),
  );
  getit.registerSingleton<NotifictionRepoImpl>(NotifictionRepoImpl(
      notifictionRemoteDataSource: NotifictionRemoteDataSourceImpl(getit())));
  getit.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(
      profileDataSource: ProfileDataSourceImpl(apiService: getit())));
}
