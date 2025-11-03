import 'package:sindbad_management_app/features/auth_feature/ui/screens/confirm_password_screen.dart';

abstract class AppRoutes {
  // Auth & Core
  static const splash = '/';
  static const signIn = '/signin';
  static const root = '/root';
  static const details = '/details';
  static const forgetPassword = '/forgetPassword';
  static const confirmPassword = '/cofirmPassword';
  static const resetPassword = '/resetPassword';

  // Offer Management
  static const offerDetails = '/offerDetails';
  static const newOffer = '/newOffer';
  static const updateOffer = '/updateOffer';

  // Order Management
  static const orderDetails = '/orderDetails';

  // Product Management
  static const addProduct = '/store/addProduct';
  static const editProduct = '/store/editProduct';

  // Other Features
  static const notification = '/notification';
  static const profile = '/profile';
  static const changePassword = '/changePassword';

  // Additional store routes (commented but kept for reference)
  static const storeHome = '/store/home';
  static const storeOrderProcessing = '/store/orderProcessing';
  static const storeProducts = '/store/products';
  static const storeSearchProduct = '/store/searchProduct';
  static const storeOffer = '/store/offer';
  static const storeStopProduct = '/store/stopProduct';
  static const storeOfferProduct = '/store/offerProduct';
  static const storeStoppedProduct = '/store/stoppedProduct';
  static const storeExcelFile = '/store/excelFile';
  static const storeReport = '/store/report';
}
