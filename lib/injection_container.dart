import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sindbad_management_app/features/offers_features/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_products_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_products_cubit/offer_products_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/data/data_source/remote/view_offer_remot_data_source_impl.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offers_features/data/repos/view_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_details_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/add_offer_use_case_1.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/add_product_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/use_cases/get_product_details_to_store_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/attribute_product/attribute_product_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/activate_products_by_ids_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/disable_products_by_ids_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/delete_product_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/edit_product_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/get_main_category_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/get_category_cubit/get_category_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/use_cases/get_main_and_sub_category_use_case.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/excell_api_services.dart';
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
import 'package:sindbad_management_app/features/orders_feature/data/data_sources/all_order_remot_data_source_imp.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/order%20cubit/orders_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/store_data_source_impl.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/download_dll_files_use_case.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/get_profile_data_usecase.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_cubt.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/reset_password_cubit/reset_password_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/remote_data/notifiction_remote_data_source.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/repo/notifiction_repo_impl.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/all_order/all_order_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/product_remote_data_source_impl.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/use_cases/get_products_usecase.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/get_profile_cubit/get_profile_cubit.dart';
import 'features/orders_feature/data/repos_impl/all_order_repo_impl.dart';
import 'features/orders_feature/data/data_sources/all_order_remot_data_source.dart';
import 'features/products_feature/view_product_features/data/data_source/add_and_edit_product_to_store_remote_data_source.dart';
import 'features/products_feature/view_product_features/data/repos/product_repository_impl.dart';
import 'features/profile_feature/data/data_source/profile_data_source.dart';
import 'features/profile_feature/data/repo/profile_repository_impl.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/get_offer_data_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/domain/usecases/update_offer_use_case.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/add_offer_cubit/add_offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_data_cubit/offer_data_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/update_offer_cubit/update_offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/order_details_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/order_invoice_usecasse.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/order_shipping_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/order_cancel_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/usecases/company_shipping_usecase.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order_details/order_details_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/invoice/order_invoice_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/cancel/cancel_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/company_shipping/cubit/company_shipping_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/get_unread_notiftion.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';
import 'core/api_service.dart';

final getit = GetIt.instance;

void initializationContainer() {
  // ----------------
  //  Servicesf
  // ----------------
  getit.registerSingleton<FlutterSecureStorage>(FlutterSecureStorage());
  getit.registerSingleton<ApiService>(ApiService());
  getit.registerSingleton<Dio>(Dio());
  getit.registerSingleton<BulkService>(
      BulkService("https://sindibad-back.com:84/", getit(), getit()));

  // ----------------
  //  Data Sources"To
  // ----------------
  getit.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
  getit.registerSingleton<AllOrderRemotDataSource>(
      AllOrderRemotDataSourceImpl(getit(), getit()));
  getit.registerSingleton<ProductRemoteDataSourceImpl>(
      ProductRemoteDataSourceImpl(getit(), getit()));
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
  getit.registerSingleton<StoreDataSourceImpl>(StoreDataSourceImpl(getit()));

  // ----------------
  //  Repositories
  // ----------------
  getit.registerSingleton<AuthentationRepositoryImp>(
      AuthentationRepositoryImp(getit()));
  getit.registerSingleton<ExcellRepositoryImpl>(ExcellRepositoryImpl(getit()));

  getit.registerSingleton<AllOrderRepoImpl>(AllOrderRepoImpl(getit()));
  getit.registerSingleton<ProductRepositoryImpl>(
      ProductRepositoryImpl(getit(), getit()));
  getit.registerSingleton<AddAndEditProductStoreRepoImpl>(
      AddAndEditProductStoreRepoImpl(getit()));
  getit.registerSingleton<OffersRepositoryImpl>(OffersRepositoryImpl(getit()));
  getit.registerSingleton<NewOfferRepositoryImpl>(
      NewOfferRepositoryImpl(getit()));
  getit.registerSingleton<NotifictionRepoImpl>(NotifictionRepoImpl(getit()));
  getit.registerSingleton<ProfileRepositoryImple>(
      ProfileRepositoryImple(getit()));

  // ----------------
  //  Use Cases
  // ----------------
  getit.registerSingleton<SignInUseCase>(SignInUseCase(getit()));
  getit.registerSingleton<GetOfferProductsUseCase>(
      GetOfferProductsUseCase(getit()));
  getit.registerSingleton<DownloadAllFilesUseCase>(
      DownloadAllFilesUseCase(getit()));
  getit.registerSingleton<GetOffersUseCase>(GetOffersUseCase(getit()));
  getit.registerSingleton<GetOfferDetailsUseCase>(
      GetOfferDetailsUseCase(getit()));
  getit.registerSingleton<GetMainAndSubCategoryUseCase>(
      GetMainAndSubCategoryUseCase(getit()));
  getit
      .registerSingleton<ForgetPasswordUseCase>(ForgetPasswordUseCase(getit()));
  getit.registerSingleton<NewOrderUsecase>(NewOrderUsecase(getit()));
  getit.registerSingleton<GetProductsUseCase>(GetProductsUseCase(getit()));
  getit.registerSingleton<ResetPasswordUseCase>(ResetPasswordUseCase(getit()));
  getit
      .registerSingleton<GetProfileDataUsecase>(GetProfileDataUsecase(getit()));
  getit.registerSingleton<ConfirmPasswordUseCase>(
      ConfirmPasswordUseCase(getit()));
  getit.registerSingleton<GetMainCategoryUseCase>(
      GetMainCategoryUseCase(getit()));
  getit.registerSingleton<DisableProductsUseCase>(
      DisableProductsUseCase(getit()));
  getit.registerSingleton<ActivateProductsUseCase>(
      ActivateProductsUseCase(getit()));
  getit.registerSingleton<AddProductUseCase>(AddProductUseCase(getit()));
  getit.registerSingleton<GetProductDetailsToStoreUseCase>(
      GetProductDetailsToStoreUseCase(getit()));
  getit.registerSingleton<DeleteProductUseCase>(DeleteProductUseCase(getit()));
  getit.registerSingleton<EditProductUseCase>(EditProductUseCase(getit()));
  // ----------------
  //  Cubits
  // ----------------
  getit.registerFactory<SignInCubit>(() => SignInCubit(getit()));
  getit.registerFactory<OfferProductsCubit>(() => OfferProductsCubit(getit()));
  getit.registerFactory<ExcelCubit>(() => ExcelCubit(getit()));
  getit.registerFactory<OrdersCubit>(() => OrdersCubit(getit()));
  getit.registerFactory<GetProfileCubit>(() => GetProfileCubit(getit()));
  getit.registerFactory<AllOrderCubit>(() => AllOrderCubit(getit()));
  getit.registerFactory<ProductsCubit>(() =>
      ProductsCubit(getit(), getit(), getit(), getit(), getit(), getit()));
  getit.registerFactory<ResetPasswordCubit>(() => ResetPasswordCubit(getit()));
  getit
      .registerFactory<ForgetPasswordCubit>(() => ForgetPasswordCubit(getit()));
  getit.registerFactory<ConfirmPasswordCubit>(
      () => ConfirmPasswordCubit(getit()));
  getit.registerFactory<GetCategory>(() => GetCategory(getit()));
  getit.registerFactory<OfferCubit>(() => OfferCubit(getit(), getit()));
  getit.registerFactory<GetCategoryNamesCubit>(
      () => GetCategoryNamesCubit(getit()));
  getit.registerFactory<AddProductToStoreCubit>(
      () => AddProductToStoreCubit(getit()));
  getit.registerFactory<AttributeProductCubit>(() => AttributeProductCubit());
  getit
      .registerFactory<ProductDetailsCubit>(() => ProductDetailsCubit(getit()));
  // Use cases for offers
  getit.registerSingleton<UpdateOfferUseCase>(UpdateOfferUseCase(getit()));
  getit.registerSingleton<GetOfferDataUseCase>(GetOfferDataUseCase(getit()));
  getit.registerSingleton<AddOfferUseCase>(AddOfferUseCase(getit()));
  // Use cases for orders
  getit.registerSingleton<OrderDetailsUsecase>(OrderDetailsUsecase(getit()));
  getit.registerSingleton<OrderInvoiceUsecase>(OrderInvoiceUsecase(getit()));
  getit.registerSingleton<OrderShippingUsecase>(OrderShippingUsecase(getit()));
  getit.registerSingleton<OrderCancelUsecase>(OrderCancelUsecase(getit()));
  getit.registerSingleton<CompanyShippingUsecase>(
      CompanyShippingUsecase(getit()));
  // Use cases for notifications
  getit.registerSingleton<GetUnreadNotiftionUseCase>(
      GetUnreadNotiftionUseCase(getit()));
  // Cubits for offers
  getit.registerFactory<UpdateOfferCubit>(() => UpdateOfferCubit(getit()));
  getit.registerFactory<OfferDataCubit>(() => OfferDataCubit(getit()));
  getit.registerFactory<AddOfferCubit>(() => AddOfferCubit(getit()));
  getit.registerFactory<OfferDetailsCubit>(() => OfferDetailsCubit(getit()));
  // Cubits for orders
  getit.registerFactory<OrderDetailsCubit>(() => OrderDetailsCubit(getit()));
  getit.registerFactory<OrderInvoiceCubit>(() => OrderInvoiceCubit(getit()));
  getit.registerFactory<ShippingCubit>(() => ShippingCubit(getit()));
  getit.registerFactory<CancelCubit>(() => CancelCubit(getit()));
  getit.registerFactory<CompanyShippingCubit>(
      () => CompanyShippingCubit(getit()));
  // Cubit for notifications
  getit.registerFactory<UnreadNotifictionCubit>(
      () => UnreadNotifictionCubit(getit()));
}
