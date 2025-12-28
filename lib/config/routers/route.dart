import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/screens/forget_password_screen.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/screens/confirm_password_screen.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/screens/login_screen.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/screens/reset_password_screen.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/screens/new_offer_screen.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/screens/add_product_page.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/screens/update_product_page.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/screen/excell_page.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/screen/notificion_screen.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/screens/view_offer_details_screen.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/screen/change_passsowrd_screen.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/screen/profile_screen.dart';
import '../../features/root.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/injection_container.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      // Store Routes
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: AppRoutes.addExcelPage,
        builder: (context, state) {
          return AddExcelPage();
        },
      ),
      GoRoute(
        path: AppRoutes.forgetPassword,
        builder: (context, state) {
          return ForgetPasswordScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.confirmPassword,
        builder: (context, state) {
          final phoneNumber = state.extra as String;
          return ConfirmPasswordScreen(phoneNumber: phoneNumber);
        },
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) {
          return ResetPasswordScreen();
        },
      ),

      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getit<OfferCubit>(),
            ),
            BlocProvider(
              create: (context) => getit<GetCategoryNamesCubit>(),
            ),
          ],
          child: const Root(),
        ),
      ),
      GoRoute(
        path: AppRoutes.newOffer,
        builder: (context, state) => const NewOfferScreen(),
      ),
      GoRoute(
        path: AppRoutes.updateOffer,
        builder: (context, state) {
          final List<dynamic> args = state.extra as List<dynamic>;
          final int offerHeadId = args[0]; // The second parameter in the list
          return UpdateOfferScreen(
            offerHeadId: offerHeadId,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.addProduct,
        builder: (context, state) {
          return AddProductPage();
        },
      ),
      GoRoute(
        path: AppRoutes.editProduct,
        builder: (context, state) {
          final extraData = state.extra as int;
          return UpdateProductPage(
            productId: extraData,
          );
        },
      ),

      GoRoute(
        path: AppRoutes.offerDetails,
        builder: (context, state) {
          final List<dynamic> args = state.extra as List<dynamic>;
          final int offerId = args[0];
          final String offerName = args[1];
          final String offertype = args[2];
          return ViewOfferDetailsScreen(
            offerId: offerId,
            offerName: offerName,
            offertype: offertype,
          );
        },
      ),

      GoRoute(
          path: AppRoutes.details,
          builder: (context, state) {
            final orderId = state.extra == null ? 0 : state.extra as int;
            final packageId = state.extra == null ? 0 : state.extra as int;
            final orderNumber = state.extra;
            final billNumber = state.extra;
            final date = state.extra;
            final itemNumber = state.extra;
            final paymentInfo = state.extra;
            final orderStatus = state.extra;
            return OrderDetails(
              orderId: orderId,
              packageId: packageId,
              orderNumber: orderNumber.toString(),
              billNumber: billNumber.toString(),
              date: date.toString(),
              itemNumber: itemNumber.toString(),
              paymentInfo: paymentInfo.toString(),
              orderStatus: orderStatus.toString(),
            );
          }),
      GoRoute(
          path: AppRoutes.notification,
          builder: (context, state) {
            return const NotificionScreen();
          }),

      GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) {
            return const ProfileScreen();
          }),
      GoRoute(
          path: AppRoutes.changePassword,
          builder: (context, state) {
            return const ChangePasssowrdScreen();
          }),
    ],
  );
}
