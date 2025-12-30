import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sindbad_management_app/config/locales_config.dart';
import 'package:sindbad_management_app/config/themes/dark_theme.dart';
import 'package:sindbad_management_app/config/themes/light_theme.dart';
import 'package:sindbad_management_app/core/services/simple_bloc_observer.dart';
import 'package:sindbad_management_app/core/utils/currancy.dart';
import 'package:sindbad_management_app/config/routers/route.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/confirm_password_cubit/confirm_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/forget_password_cubit.dart/forget_password_cubit.dart';
import 'package:sindbad_management_app/features/auth_feature/ui/manger/sgin_in_cubit/sgin_in_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/manager/offer_products_cubit/offer_products_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/manager/update_offer_cubit/update_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order%20cubit/orders_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/attribute_product/attribute_product_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/get_category_cubit/get_category_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_cubt.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/reset_password_cubit/reset_password_cubit.dart';
import 'package:sindbad_management_app/features/notifiction_featurs/ui/cubit/notifiction_cubit/unread_notifiction_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/cancel/cancel_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/company_shipping/cubit/company_shipping_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/invoice/order_invoice_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order_details/order_details_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/shipping/shipping_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';
import 'injection_container.dart';
import 'features/orders_feature/ui/manager/button_disable/button_disable_cubit.dart';
import 'features/profile_feature/ui/cubit/setting_cubit/app_settings_cubit.dart';

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
          create: (_) => SignInCubit(getit()),
        ),
        BlocProvider(create: (_) => OrdersCubit(getit())),
        BlocProvider(create: (_) => ExcelCubit(getit(), getit(), getit())),
        BlocProvider(
            create: (_) => ProductsCubit(
                getit(), getit(), getit(), getit(), getit(), getit())),
        // BlocProvider(
        //   create: (_) => GetProfileCubit(getit()),
        // ),
        BlocProvider(
          create: (_) => ResetPasswordCubit(getit()),
        ),
        BlocProvider(
          create: (_) => ForgetPasswordCubit(getit()),
        ),
        BlocProvider(
          create: (_) => ConfirmPasswordCubit(getit()),
        ),
        BlocProvider(
          create: (_) => OrdersCubit(getit()),
        ),
        BlocProvider(
          create: (_) => GetCategory(getit()),
        ),
        BlocProvider(
          create: (_) => ProductDetailsCubit(getit()),
        ),
        BlocProvider(
          create: (_) => OfferCubit(
              getit(), getit(), getit(), getit(), getit(), getit(), getit()),
        ),
        BlocProvider(
          create: (_) => AddProductToStoreCubit(getit()),
        ),
        BlocProvider(
          create: (_) => AttributeProductCubit(),
        ),
        BlocProvider(
          create: (_) => OfferDetailsCubit(getit()),
        ),
        BlocProvider(
          create: (_) => OfferProductsCubit(getit()),
        ),
        BlocProvider(
          create: (_) => UpdateOfferCubit(getit()),
        ),
        // BlocProvider(
        //   create: (_) => OfferDataCubit(getit()),
        // ),
        // BlocProvider(
        //   create: (_) => AddOfferCubit(getit()),
        // ),
        BlocProvider(
          create: (_) => OrderDetailsCubit(getit()),
        ),
        BlocProvider(create: (_) => ButtonDisableCubit()),
        BlocProvider(
          create: (_) => OrderInvoiceCubit(getit()),
        ),
        BlocProvider(
          create: (_) => ShippingCubit(getit()),
        ),
        BlocProvider(
          create: (_) => CancelCubit(getit()),
        ),
        BlocProvider(
          create: (_) => CompanyShippingCubit(getit()),
        ),
        BlocProvider(
          create: (_) => UnreadNotifictionCubit(getit()),
        ),
        BlocProvider(
          create: (_) => GetCategoryNamesCubit(getit()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 1000),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => BlocBuilder<SettingsCubit, SettingsState>(
          bloc: getit<SettingsCubit>(),
          builder: (context, state) {
            final settingsCubit = getit<SettingsCubit>();
            return MaterialApp.router(
              // for using with the device preview //
              // locale: DevicePreview.locale(context),
              builder: DevicePreview.appBuilder,
              ///////////////////////////////////////
              routerConfig: AppRouter.router,
              theme: LightTheme.theme,
              darkTheme: DarkTheme.theme,
              themeMode: settingsCubit.themeMode,
              localizationsDelegates: LocalesConfig.localizationsDelegates,
              supportedLocales: LocalesConfig.supportedLocales,
              locale: settingsCubit.locale,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
