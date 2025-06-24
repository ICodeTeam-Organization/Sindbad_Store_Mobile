import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sindbad_management_app/features/auth_feature/data/data_source/auth_remote_data_source.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repo/auth_repo_impl.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/remote_data/notifiction_remote_data_source.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/repo/notifiction_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/data/data_sources/all_order_remot_data_source.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/data/data_source/view_product_remote_data_source.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/data/data_sources/all_order_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/data_source/remote/new_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/data_source/remote/view_offer_remot_data_source.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/View_offer_repo_impl.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/data/data_sources/all_order_remot_data_source.dart';
// import 'package:get_it/get_it.dart';
// import 'package:test_order_life_cycle/core/api_service.dart';
// import 'package:test_order_life_cycle/features/auth_feature/data/data_source/auth_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/auth_feature/data/repo/auth_repo_impl.dart';
// import 'package:test_order_life_cycle/features/delivery/Parcel_Delivery/data/data_source/remote/parcel_delivery_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/delivery/Parcel_Delivery/data/repos/parcel_delivery_repo_impl.dart';
// import 'package:test_order_life_cycle/features/delivery/Ready_for_Delivery/data/data_source/remote/ready_for_delivery_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/delivery/Ready_for_Delivery/data/repos/ready_for_delivery_repo_impl.dart';
// import 'package:test_order_life_cycle/features/delivery/Receive_Parcels/data/data_source/remote/receive_parcels_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/delivery/Receive_Parcels/data/repos/receive_parcels_repo_impl.dart';
// import 'package:test_order_life_cycle/features/store/home/data/data_sources/all_order_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/store/home/data/repos/all_order_repo_impl.dart';
// import 'package:test_order_life_cycle/features/store/order_processing/data/data_sources/order_processing_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/store/order_processing/data/repos/order_processing_repo_impl.dart';

// import 'package:test_order_life_cycle/features/y_accountant/confirm_payment/data/data_source/remote/bound_remote_data_source.dart';
// import 'package:test_order_life_cycle/features/y_accountant/confirm_payment/data/repo/bound_erpo_impl.dart';
// import 'package:test_order_life_cycle/features/y_accountant/confirm_payment/domin/repo/y_accontant_repo.dart';

// import 'package:test_order_life_cycle/features/delivery/Receive_Parcels/data/data_source/remote/receive_parcels_remote_data_source.dart';

import '../features/order_management _features/data/repos_impl/all_order_repo_impl.dart';
import '../features/order_management _features/data/data_sources/all_order_remot_data_source.dart';
import '../features/product_features/add_and_edit_product_feature/data/data_source/add_and_edit_product_to_store_remote_data_source.dart';
import '../features/product_features/view_product_features/data/repos/view_product_store_repo_impl.dart';
import 'api_service.dart';

final getit = GetIt.instance;

void setupServiceLocator() {
  getit.registerSingleton<ApiService>(ApiService(Dio()));

  getit.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );
  getit.registerSingleton<AuthRepoImpl>(AuthRepoImpl(
      authRemoteDataSource: AuthRemoteDataSourceImpl(
    getit.get<ApiService>(),
    getit.get<FlutterSecureStorage>(),
  )));
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
  // getit.registerSingleton<YAccontantRepoimple>(YAccontantRepoimple(
  //     boundRemoteDataSource: BoundRemoteDataSourceImpl(
  //   apiService: getit.get<ApiService>(),
  //   secureStorage: getit.get<FlutterSecureStorage>(),
  // )));

  // getit.registerSingleton<AllOrderRepoImpl>(
  //   AllOrderRepoImpl(
  //     AllOrderRemotDataSourceImpl(
  //       getit.get<ApiService>(),
  //       getit.get<FlutterSecureStorage>(),
  //     ),
  //   ),
  // );
  // getit.registerSingleton<OrderProcessingRepoImpl>(
  //   OrderProcessingRepoImpl(
  //     OrderProcessingRemotDataSourceImpl(
  //       getit.get<ApiService>(),
  //       getit.get<FlutterSecureStorage>(),
  //     ),
  //   ),
  // );
  // getit.registerSingleton<ParcelDeliveryRepoImpl>(ParcelDeliveryRepoImpl(
  //     parcelDeliveryRemoteDataSource: ParcelDeliveryRemoteDataSourceImpl(
  //   getit.get<ApiService>(),
  //   getit.get<FlutterSecureStorage>(),
  // ),));
  // getit.registerSingleton<ReceiveParcelsRepoImpl>(ReceiveParcelsRepoImpl(
  //   receiveParcelsRemoteDataSource: ReceiveParcelsRemoteDataSourceImpl(
  //     getit.get<ApiService>(),
  //     getit.get<FlutterSecureStorage>(),
  //   ),
  // ));
  // getit.registerSingleton<ReadyForDeliveryRepoImpl>(ReadyForDeliveryRepoImpl(
  //   readyForDeliveryRemoteDataSource: ReadyForDeliveryRemoteDataSourceImpl(
  //     getit.get<ApiService>(),
  //     getit.get<FlutterSecureStorage>(),
  //   ),
  // ));
  // getit.registerSingleton<AuthRepoImpl>(AuthRepoImpl(
  //     authRemoteDataSource: AuthRemoteDataSourceImpl(
  //   getit.get<ApiService>(),
  //   getit.get<FlutterSecureStorage>(),
  // )));
}
// getit.registerSingleton<AllOrderRepoImpl>(AllOrderRepoImpl(allOrderRemoteDataSource:  AllOrderRemotDataSourceImpl(
//   getit.get<ApiService>(),
//   getit.get<FlutterSecureStorage>(),
// )

//    ));
// getit.registerSingleton<HomeRepoImpl>(HomeRepoImpl(
//     homeRemoteDataSource: HomeRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   getit.get<FlutterSecureStorage>(),
// )));

// getit.registerSingleton<AuthRepoImpl>(AuthRepoImpl(
//     authRemoteDataSource: AuthRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   getit.get<FlutterSecureStorage>(),
// )));

// getit.registerSingleton<SginUpRepoImpl>(SginUpRepoImpl(
//     sginUPRemoteDataSource: SginUPRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   // getit.get<FlutterSecureStorage>(),
// )));

// getit.registerSingleton<SginInRepoImpl>(SginInRepoImpl(
//     sginInRemoteDataSource: SginInRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   // getit.get<FlutterSecureStorage>(),
// )));

//   getit.registerSingleton<OrderRepoImpl>(
//     OrderRepoImpl(
//         orderRemoteDataSource:OrderRemoteDataSourceImpl(
//           getit.get<ApiService>(),
//           getit.get<FlutterSecureStorage>(),
//           )
//         ),
// );
// getit.registerSingleton<ProductDetailsRepoImpl>(ProductDetailsRepoImpl(
//     productDetailsRemoteDataSource:
//         ProductDetailsRemoteDataSourceImpl(getit.get<ApiService>())));

// getit.registerSingleton<CartRepoImpl>(CartRepoImpl(
//     cartRemoteDataSource: CartRemoteDataSourceImpl(
//         apiService: getit.get<ApiService>(),
//         secureStorage: const FlutterSecureStorage())));
//     getit.registerSingleton<CartRepoImpl>(CartRepoImpl(
// cartRemoteDataSource:
//     CartRemoteDataSourceImpl(apiService:  getit.get<ApiService>(),secureStorage: const FlutterSecureStorage())));
// getit.registerSingleton<CartRepoImpl>(CartRepoImpl(
//     cartRemoteDataSource: CartRemoteDataSourceImpl(
//         apiService: getit.get<ApiService>(),
//         secureStorage: const FlutterSecureStorage())));
//     getit.registerSingleton<CartRepoImpl>(CartRepoImpl(
// cartRemoteDataSource:
//     CartRemoteDataSourceImpl(apiService:  getit.get<ApiService>(),secureStorage: const FlutterSecureStorage())));

// getit.registerSingleton<OurShopRepoImpl>(OurShopRepoImpl(
//     ourShopRemoteDataSource: OurShopRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   // getit.get<FlutterSecureStorage>(),
// )));

// getit.registerSingleton<ShopsRepoeImpl>(ShopsRepoeImpl(
//   ShopsRemoteDataSourceImpl(getit.get<ApiService>()),
// ));

// getit.registerSingleton<OnlineStoreRepoeImpl>(OnlineStoreRepoeImpl(
//   storesRemoteDataSource:
//       OnlineStoresRemoteDataSourceImpl(getit.get<ApiService>()),
// ));

//////////////////////////////////////////
///
///
// getit.registerSingleton<OrderTrackRepoImpl>(
//   OrderTrackRepoImpl(
//     orderTrackRemoteDataSource: OrderTrackRemoteDataSourceImpl(
//       getit.get<ApiService>(),
//       getit.get<FlutterSecureStorage>(),
//     ),
//   ),
// );
// getit.registerSingleton<MyOrderRepoImpl>(
//   MyOrderRepoImpl(
//     MyOrderRemoteDataSourceImpl(
//       getit.get<ApiService>(),
//       getit.get<FlutterSecureStorage>(),
//     ),
//   ),
// );

// getit.registerSingleton<ShippingAddressRepoImpl>(ShippingAddressRepoImpl(
//     shippingAddressRemoteDataSource: ShippingAddressRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   getit.get<FlutterSecureStorage>(),
// )));

// getit.registerSingleton<ShowOrderRepoImpl>(ShowOrderRepoImpl(
//     showOrderRemoteDataSource: ShowOrderRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   getit.get<FlutterSecureStorage>(),
// )));

// getit.registerSingleton<SpecialOrderRepoImpl>(SpecialOrderRepoImpl(
//     sepcialOrdersRemoteDataSource: SepcialOrdersRemoteDataSourceImpl(
//   getit.get<ApiService>(),
//   getit.get<FlutterSecureStorage>(),
// )));
