import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sindbad_management_app/core/services/excell_api_services.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_soure_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repository/authentation_repository_imp.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/confirm_password_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/forget_password_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/reset_password_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/confirm_password_cubit/confirm_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/data_sources/all_order_remot_data_source_imp.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/get_profile_data_usecase.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/reset_password_cubit/reset_password_cubit.dart';
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
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/use_cases/get_products_by_filter_use_case.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/ui/manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/get_profile_cubit/get_profile_cubit.dart';
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
  getit.registerSingleton<BulkService>(
      BulkService("https://sindibad-back.com:84/"));

  // ----------------
  //  Data Sources
  // ----------------
  getit.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  getit.registerSingleton<AllOrderRemotDataSource>(
      AllOrderRemotDataSourceImpl(getit(), getit()));
  getit.registerSingleton<ViewProductRemoteDataSource>(
      ViewProductRemoteDataSourceImpl(getit(), getit()));
  getit.registerSingleton<AddProductToStoreRemoteDataSourceImpl>(
      AddProductToStoreRemoteDataSourceImpl(getit(), getit()));
  getit.registerSingleton<ViewOfferRemotDataSourceImpl>(
      ViewOfferRemotDataSourceImpl(getit(), getit()));
  getit.registerSingleton<NewOfferRemotDataSourceImpl>(
      NewOfferRemotDataSourceImpl(getit(), getit()));
  getit.registerSingleton<NotifictionRemoteDataSourceImpl>(
      NotifictionRemoteDataSourceImpl(getit()));
  getit
      .registerSingleton<ProfileDataSourceImpl>(ProfileDataSourceImpl(getit()));

  // ----------------
  //  Repositories
  // ----------------
  getit.registerSingleton<AuthentationRepositoryImp>(
      AuthentationRepositoryImp(getit()));

  getit.registerSingleton<AllOrderRepoImpl>(AllOrderRepoImpl(getit()));
  getit.registerSingleton<ViewProductRepoImpl>(ViewProductRepoImpl(getit()));
  getit.registerSingleton<AddAndEditProductStoreRepoImpl>(
      AddAndEditProductStoreRepoImpl(getit()));
  getit.registerSingleton<ViewOfferRepoImpl>(ViewOfferRepoImpl(getit()));
  getit.registerSingleton<NewOfferRepoImpl>(NewOfferRepoImpl(getit()));
  getit.registerSingleton<NotifictionRepoImpl>(NotifictionRepoImpl(getit()));
  getit.registerSingleton<ProfileRepoImpl>(ProfileRepoImpl(getit()));

  // ----------------
  //  Use Cases
  // ----------------
  getit.registerSingleton<SignInUseCase>(SignInUseCase(getit()));
  getit
      .registerSingleton<ForgetPasswordUseCase>(ForgetPasswordUseCase(getit()));
  getit.registerSingleton<AllOrderUsecase>(AllOrderUsecase(getit()));
  getit.registerSingleton<GetProductsByFilterUseCase>(
      GetProductsByFilterUseCase(getit()));
  getit.registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(getit()));
  getit
      .registerSingleton<GetProfileDataUsecase>(GetProfileDataUsecase(getit()));
  getit.registerSingleton<ConfirmPasswordUseCase>(
      ConfirmPasswordUseCase(getit()));

  // ----------------
  //  Cubits
  // ----------------
  getit.registerFactory<SignInCubit>(() => SignInCubit(getit()));
  getit.registerFactory<GetProfileCubit>(() => GetProfileCubit(getit()));
  getit.registerFactory<AllOrderCubit>(() => AllOrderCubit(getit()));
  getit.registerFactory<GetStoreProductsWithFilterCubit>(
      () => GetStoreProductsWithFilterCubit(getit()));
  getit.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getit()));
  getit
      .registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getit()));
  getit.registerFactory<ConfirmPasswordCubit>(
      () => ConfirmPasswordCubit(getit()));
}
