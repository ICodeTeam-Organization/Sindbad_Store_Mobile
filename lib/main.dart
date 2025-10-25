import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sindbad_management_app/config/locales_config.dart';
import 'package:sindbad_management_app/core/utils/currancy.dart';
import 'package:sindbad_management_app/config/routers/route.dart';
import 'package:sindbad_management_app/features/auth_feature/data/repo/auth_repo_impl.dart';
import 'package:sindbad_management_app/features/auth_feature/domain/usecase/sign_in_use_case.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/data/repo/notifiction_repo_impl.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/domin/use_case/get_unread_notiftion.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';
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
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/company_shipping_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_cancel_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/cancel/cancel_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/company_shipping/cubit/company_shipping_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/invoice/order_invoice_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_and_edit_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/use_cases/get_main_and_sub_category_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'injection_container.dart';
import 'core/simple_bloc_observer.dart';
import 'features/order_management _features/domain/usecases/order_details_usecase.dart';
import 'features/order_management _features/domain/usecases/order_shipping_usecase.dart';
import 'features/order_management _features/ui/manager/all_order/all_order_cubit.dart';
import 'features/order_management _features/ui/manager/button_disable/button_disable_cubit.dart';

// class MyhttpsOverride extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//h       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }

void main() async {
  // HttpOverrides.global = MyhttpsOverride();
  WidgetsFlutterBinding.ensureInitialized();
  initializationContainer();
  // Initialize Hive and open the box
  await Hive.initFlutter();

  /// Register the adapter this line should be,
  /// the first before any open Box mehtod
  Hive.registerAdapter(CategoryEntityAdapter());
  await Hive.openBox<CategoryEntity>('categotyBox');
  Bloc.observer = SimpleBlocObserver();
  await Currancy.initCurrency();

  //splahs screen
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

class SindbadManagementApp extends StatefulWidget {
  const SindbadManagementApp({super.key});

  @override
  State<SindbadManagementApp> createState() => _SindbadManagementAppState();
}

class _SindbadManagementAppState extends State<SindbadManagementApp> {
  @override
  void initState() {
    super.initState();
    // initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ///block provider instance.
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
        BlocProvider(
            create: (context) => CompanyShippingCubit(CompanyShippingUsecase(
                  allOrderRepo: getit.get<AllOrderRepoImpl>(),
                ))),
        BlocProvider(
          create: (context) => UnreadNotifictionCubit(GetUnreadNotiftionUseCase(
              notifictionRepo: getit.get<NotifictionRepoImpl>())),
        ),
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
        BlocProvider(
            create: (context) =>
                GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
                  getit.get<AddAndEditProductStoreRepoImpl>(),
                ))),
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
          localizationsDelegates: LocalesConfig.localizationsDelegates,
          supportedLocales: LocalesConfig.supportedLocales,
          locale: LocalesConfig.defaultLocale,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
