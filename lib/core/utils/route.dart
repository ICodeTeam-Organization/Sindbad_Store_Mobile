import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/features/order/ui/screen/primary_button.dart';
import 'package:sindbad_management_app/store_app_features/add_product/ui/screen/store_add_product.dart';
import 'package:sindbad_management_app/store_app_features/excel_file/ui/screen/store_excel_file.dart';
import 'package:sindbad_management_app/store_app_features/home/ui/screen/store_home_page.dart';
import 'package:sindbad_management_app/store_app_features/offer_product/ui/screen/store_offer_product.dart';
import 'package:sindbad_management_app/store_app_features/offers/ui/screen/store_offer.dart';
import 'package:sindbad_management_app/store_app_features/order_processing/ui/screen/store_order_processing.dart';
import 'package:sindbad_management_app/store_app_features/products/ui/screen/store_products.dart';
import 'package:sindbad_management_app/store_app_features/report/ui/screen/store_report.dart';
import 'package:sindbad_management_app/store_app_features/search_product/ui/screen/store_search_product.dart';
import 'package:sindbad_management_app/store_app_features/stop_product/ui/screen/store_stop_prodect.dart';
import 'package:sindbad_management_app/store_app_features/stopped_product/ui/screen/store_stopped_product.dart';

import '../../features/auth_features/ui/screen/sign_in_screen.dart';
import '../../features/root.dart';
// Update with the actual import paths for your views

class StoreRouters {
  String signIn = '/';
  String root = '/root';
  ///////////////////////////////////////////////////
  ///////////////////////////////////////////////////

  String kStoreHome = '/store/home';
  String kStoreAddProduct = '/store/addProduct';
  String kStoreOrderProcessing = '/store/orderProcessing';
  String kStoreProducts = '/store/products';
  String kStoreSearchProduct = '/store/searchProduct';
  String kStoreOffer = '/store/offer';
  String kStoreStopProduct = '/store/stopProduct';
  String kStoreOfferProduct = '/store/offerProduct';
  String kStoreStoppedProduct = '/store/stoppedProduct';
  String kStoreExcelFile = '/store/excelFile';
  String kStoreReport = '/store/report';
}

abstract class AppRouter {
  static const signIn = '/';

  static StoreRouters storeRouters = StoreRouters();
  static final router = GoRouter(
    routes: [
      // Store Routes
      GoRoute(
        path: AppRouter.storeRouters.signIn,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.root,
        builder: (context, state) => const Root(),
      ),
      ///////////////////////////////////////////////////////
      //////////////////////////////////////////////////////
      /////////////////////////////////////////////////////
      GoRoute(
        path: AppRouter.storeRouters.kStoreAddProduct,
        builder: (context, state) => const StoreAddProduct(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreOrderProcessing,
        builder: (context, state) => const StoreOrderProcessing(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreProducts,
        builder: (context, state) => const StoreProducts(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreSearchProduct,
        builder: (context, state) => const StoreSearchProduct(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreOffer,
        builder: (context, state) => const StoreOffer(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreStopProduct,
        builder: (context, state) => const StoreStopProduct(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreOfferProduct,
        builder: (context, state) => const StoreOfferProduct(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreStoppedProduct,
        builder: (context, state) => const StoreStoppedProduct(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreExcelFile,
        builder: (context, state) => const StoreExcelFile(),
      ),
      GoRoute(
        path: AppRouter.storeRouters.kStoreReport,
        builder: (context, state) => const StoreReport(),
      ),
    ],
  );
}









// abstract class AppRouter {
//   ///////////////////////////////
//   /// login router
//   static const kLoginScreen = '/';

//   // Accountant Routes
//   static AcontantRouters acontantRouters = AcontantRouters();
  
//   // Accountant Routes
//   static const kAccountantHome = '/accountant/home';
//   static const kAccountantConfirm = '/accountant/confirm';
//   static const kAccountantReport = '/accountant/report';
//   static const kAccountantMovement = '/accountant/movement';
//   static const kAccountantSearch = '/accountant/search';
//   static const kAccountantMatching = '/accountant/matching';
//   static const kAccountantExchange = '/accountant/exchange';
//   static const kAccountantCancel = '/accountant/cancel';
//   static const kAccountantAccountBalance = '/accountant/balance';
//   static const kAccountantAddBond = '/accountant/addBond';
//   static const kAccountantAskBond = '/accountant/askBond';
//   static const kAccountantReportBond = '/accountant/reportBond';

//   // Admin Routes
//   static const kAdminHome = '/admin/home';
//   static const kOrdersScreen = '/admin/orders';
//   static const kCancelOrders = '/admin/cancelOrders';
//   static const kPrepareOrder = '/admin/prepareOrder';

//   // Store Routes
//   static const kStoreHome = '/store/home';
//   static const kStoreAddProduct = '/store/addProduct';
//   static const kStoreOrderProcessing = '/store/orderProcessing';
//   static const kStoreProducts = '/store/products';
//   static const kStoreSearchProduct = '/store/searchProduct';
//   static const kStoreOffer = '/store/offer';
//   static const kStoreStopProduct = '/store/stopProduct';
//   static const kStoreOfferProduct = '/store/offerProduct';
//   static const kStoreStoppedProduct = '/store/stoppedProduct';
//   static const kStoreExcelFile = '/store/excelFile';
//   static const kStoreReport = '/store/report';

//   // Delivery Routes
//   static const kDeliverHomePage = '/deliver/home';
//   static const kParcelDelivered = '/deliver/parcelDelivered';
//   static const kParcelDelivery = '/deliver/parcelDelivery';
//   static const kParcelRoad = '/deliver/parcelRoad';
//   static const kParcelsReceived = '/deliver/parcelsReceived';
//   static const kReceiveParcels = '/deliver/receiveParcels';
//   static const kRemainingParcels = '/deliver/remainingParcels';

//   // MND Routes
//   static const kMndHomePage = '/mnd/home';
//   static const kMnd22OrderPrecedent = '/mnd/orderPrecedent';
//   static const kMnd22OrderReady = '/mnd/orderReady';
//   static const kMnd2OrderPrice = '/mnd/orderPrice';

//   static final router = GoRouter(
//     routes: [
//       // Accountant Routes
//       GoRoute(
//         path: kLoginScreen,
//         builder: (context, state) => const LoginScreen(),
//       ),
//       GoRoute(
//         path: kAccountantHome,
//         builder: (context, state) => const HomePage(),
//       ),
//       GoRoute(
//         path: kAccountantConfirm,
//         builder: (context, state) => const ConfirmPayment(),
//       ),
//       GoRoute(
//         path: kAccountantReport,
//         builder: (context, state) => const ConfirmPaymentReport(),
//       ),
//       GoRoute(
//         path: kAccountantMovement,
//         builder: (context, state) => const BankMovmentReport(),
//       ),
//       GoRoute(
//         path: kAccountantSearch,
//         builder: (context, state) => const SearchPayment(),
//       ),
//       GoRoute(
//         path: kAccountantMatching,
//         builder: (context, state) => const MatchingMovment(),
//       ),
//       GoRoute(
//         path: kAccountantExchange,
//         builder: (context, state) => const ExchangeBond(),
//       ),
//       GoRoute(
//         path: kAccountantCancel,
//         builder: (context, state) => const CancelPayment(),
//       ),
//       GoRoute(
//         path: kAccountantAccountBalance,
//         builder: (context, state) => const BankAccountBalanceReport(),
//       ),
//       GoRoute(
//         path: kAccountantAddBond,
//         builder: (context, state) => const AddExchangeBond(),
//       ),
//       GoRoute(
//         path: kAccountantAskBond,
//         builder: (context, state) => const AskExchangeBond(),
//       ),
//       GoRoute(
//         path: kAccountantReportBond,
//         builder: (context, state) => const ExchangeBondReport(),
//       ),

//       // Admin Routes
//       GoRoute(
//         path: kAdminHome,
//         builder: (context, state) => const HomeAdminScreen(),
//       ),
//       GoRoute(
//         path: kOrdersScreen,
//         builder: (context, state) => const OrdersAdminScreen(),
//       ),
//       GoRoute(
//         path: kCancelOrders,
//         builder: (context, state) => const CancelOrdersAdminScreen(),
//       ),
//       GoRoute(
//         path: kPrepareOrder,
//         builder: (context, state) => const PrepareOrderAdminScreen(),
//       ),

//       // Store Routes
//       GoRoute(
//         path: kStoreHome,
//         builder: (context, state) => const StoreHomePage(),
//       ),
//       GoRoute(
//         path: kStoreAddProduct,
//         builder: (context, state) => const StoreAddProduct(),
//       ),
//       GoRoute(
//         path: kStoreOrderProcessing,
//         builder: (context, state) => const StoreOrderProcessing(),
//       ),
//       GoRoute(
//         path: kStoreProducts,
//         builder: (context, state) => const StoreProducts(),
//       ),
//       GoRoute(
//         path: kStoreSearchProduct,
//         builder: (context, state) => const StoreSearchProduct(),
//       ),
//       GoRoute(
//         path: kStoreOffer,
//         builder: (context, state) => const StoreOffer(),
//       ),
//       GoRoute(
//         path: kStoreStopProduct,
//         builder: (context, state) => const StoreStopProduct(),
//       ),
//       GoRoute(
//         path: kStoreOfferProduct,
//         builder: (context, state) => const StoreOfferProduct(),
//       ),
//       GoRoute(
//         path: kStoreStoppedProduct,
//         builder: (context, state) => const StoreStoppedProduct(),
//       ),
//       GoRoute(
//         path: kStoreExcelFile,
//         builder: (context, state) => const StoreExcelFile(),
//       ),
//       GoRoute(
//         path: kStoreReport,
//         builder: (context, state) => const StoreReport(),
//       ),

//       // Delivery Routes
//       GoRoute(
//         path: kDeliverHomePage,
//         builder: (context, state) =>  Homescreen(),
//       ),
//       GoRoute(
//         path: kParcelDelivered,
//         builder: (context, state) =>  Parceldelivered(),
//       ),
//       GoRoute(
//         path: kParcelDelivery,
//         builder: (context, state) =>  ParcelDelivery(),
//       ),
//       GoRoute(
//         path: kParcelRoad,
//         builder: (context, state) =>  Parcelroad(),
//       ),
//       GoRoute(
//         path: kParcelsReceived,
//         builder: (context, state) =>  Parcelsreceived(),
//       ),
//       GoRoute(
//         path: kReceiveParcels,
//         builder: (context, state) => const ReceiveParcels(),
//       ),
//       GoRoute(
//         path: kRemainingParcels,
//         builder: (context, state) =>  Remainingparcels(),
//       ),

//       // MND Routes
//       GoRoute(
//         path: kMndHomePage,
//         builder: (context, state) =>  home_mnd2(),
//       ),
//       GoRoute(
//         path: kMnd22OrderPrecedent,
//         builder: (context, state) => const mnd22_OrderPrecedend(),
//       ),
//       GoRoute(
//         path: kMnd22OrderReady,
//         builder: (context, state) =>  mnd22_order_ready(),
//       ),
//       GoRoute(
//         path: kMnd2OrderPrice,
//         builder: (context, state) =>  mnd2_order_price(),
//       ),
//     ],
//   );
// }
