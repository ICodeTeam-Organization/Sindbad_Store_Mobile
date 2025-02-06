import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repo/auth_repo_impl.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/add_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/get_offer_data_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/get_offer_products_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/usecases/update_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/add_offer_cubit/add_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_data_cubit/offer_data_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_products_cubit/offer_products_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/update_offer_cubit/update_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/View_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/change_status_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/delete_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_details_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/change_status_offer_cubit/change_status_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/delete_offer_cubit/delete_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_cancel_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/cancel/cancel_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/invoice/order_invoice_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/refresh/refresh_page_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/firebase_options.dart';

import 'core/setup_service_locator.dart';
import 'core/simple_bloc_observer.dart';
import 'features/order_management _features/domain/usecases/order_details_usecase.dart';
import 'features/order_management _features/domain/usecases/order_shipping_usecase.dart';
import 'features/order_management _features/ui/manager/all_order/all_order_cubit.dart';
import 'features/order_management _features/ui/manager/button_disable/button_disable_cubit.dart';

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => SindbadManagementApp(), // Wrap your app
      ),
    );
  }
          // const SindbadManagementApp()
          );
}

class SindbadManagementApp extends StatelessWidget {
  const SindbadManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => OfferDetailsCubit(GetOfferDetailsUseCase(
                  getit<ViewOfferRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) => OfferProductsCubit(GetOfferProductsUseCase(
                  getit<NewOfferRepoImpl>(),
                ))),
        BlocProvider(
          create: (context) => OfferCubit(GetOfferUseCase(
            getit<ViewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => DeleteOfferCubit(DeleteOfferUseCase(
            getit<ViewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => ChangeStatusOfferCubit(ChangeStatusOfferUseCase(
            getit<ViewOfferRepoImpl>(),
          )),
        ),
        // BlocProvider(
        //   create: (context) => StatusOfferCubit(),
        //   child: ViewOfferBody(),
        // ),
        BlocProvider(
          create: (context) => UpdateOfferCubit(UpdateOfferUseCase(
            getit<NewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => OfferDataCubit(GetOfferDataUseCase(
            getit<NewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => AddOfferCubit(AddOfferUseCase(
            getit<NewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
            create: (context) => SignInCubitCubit(SignInUseCase(
                  getit.get<AuthRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) => AllOrderCubit(AllOrderUsecase(
                  getit.get<AllOrderRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) => OrderDetailsCubit(OrderDetailsUsecase(
                  getit.get<AllOrderRepoImpl>(),
                ))),
        BlocProvider(create: (context) => RefreshPageCubit()),
        BlocProvider(create: (context) => ButtonDisableCubit()),
        BlocProvider(
            create: (context) => OrderInvoiceCubit(OrderInvoiceUsecase(
                  allOrderRepo: getit.get<AllOrderRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) => ShippingCubit(OrderShippingUsecase(
                  allOrderRepo: getit.get<AllOrderRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) => CancelCubit(OrderCancelUsecase(
                  allOrderRepo: getit.get<AllOrderRepoImpl>(),
                ))),
        // BlocProvider(
        //     create: (context) => OrderDetailsCubit(OrderDetailsUsecase(
        //           getit.get<AllOrderRepoImpl>(),
        //         ))),
        // BlocProvider(create: (context) => RefreshPageCubit()),
        // BlocProvider(
        //     create: (context) => OrderInvoiceCubit(OrderInvoiceUsecase(
        //           allOrderRepo: getit.get<AllOrderRepoImpl>(),
        //         ))),
        // BlocProvider(
        //     create: (context) => ShippingCubit(OrderShippingUsecase(
        //           allOrderRepo: getit.get<AllOrderRepoImpl>(),
        //         ))),
        // BlocProvider(
        //     create: (context) => CancelCubit(OrderCancelUsecase(
        //           allOrderRepo: getit.get<AllOrderRepoImpl>(),
        //         ))),

        // //for add product
        // BlocProvider(
        //     create: (context) =>
        //         AddProductToStoreCubit(AddProductToStoreUseCase(
        //           addProductStoreRepo: getit.get<AddProductStoreRepoImpl>(),
        //         ))),
        // BlocProvider(create: (context) => AddImageToProductAddCubit()),
        // BlocProvider(
        //     create: (context) =>
        //         GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
        //           getit.get<AddProductStoreRepoImpl>(),
        //         ))),
        // BlocProvider(
        //     create: (context) =>
        //         GetBrandsByCategoryIdCubit(GetBrandsByMainCategoryIdUseCase(
        //           getit.get<AddProductStoreRepoImpl>(),
        //         ))),
        // BlocProvider(create: (context) => AddAttributeProductDartCubit()),
        // //
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 1000),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          // for using with the device preview //
          // locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          ///////////////////////////////////////
          routerConfig: AppRouter.router,
          theme: ThemeData(
            textTheme: GoogleFonts.cairoTextTheme(
              Theme.of(context).textTheme,
            ),
            useMaterial3: false,
            scaffoldBackgroundColor:
                const Color(0xfffffbfb), // Set default background color
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', 'AR'), // Arabic, no country code
          ],
          locale: const Locale('ar', 'AR'),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
