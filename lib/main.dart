import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/auth_features/data/repos_impl/sign_in_repo_impl.dart';
import 'package:sindbad_management_app/features/auth_features/domain/usecases/sign_in_usecase.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/data/repos_impl/all_order_repo_impl.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_cancel_usecase.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/cancel/cancel_cubit.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/refresh/refresh_page_cubit.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/invoice/order_invoice_cubit.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/shipping/shipping_cubit.dart';
// import 'package:sindbad_management_app/features/order_management%20_features/ui/screen/order_details.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/data/repos/new_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/usecases/add_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/domain/usecases/get_offer_products_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/manager/add_offer_cubit/add_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/manager/offer_products_cubit/offer_products_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/View_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/change_status_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/delete_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_details_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/change_status_offer_cubit/change_status_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/cubit/status_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/delete_offer_cubit/delete_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/view_offer_body.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/repos/add_product_store_repo.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/usecases/get_main_and_sub_category_use_case.dart';

import 'core/setup_service_locator.dart';
import 'core/simple_bloc_observer.dart';
import 'features/auth_features/ui/manager/cubit/sign_in_cubit.dart';
// import 'features/order_management _features/domain/usecases/order_details_usecase.dart';
// import 'features/order_management _features/domain/usecases/order_shipping_usecase.dart';
import 'features/product_features/add_and_edit_product_feature/domain/usecases/add_product_to_store_use_case.dart';
import 'features/product_features/add_and_edit_product_feature/domain/usecases/get_brands_by_main_category_id_use_case.dart';
import 'features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import 'features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'features/product_features/add_and_edit_product_feature/ui/manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import 'features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  Bloc.observer = SimpleBlocObserver();
  runApp(const SindbadManagementApp());
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
          create: (context) => DeleteOfferCubit(DeleteOfferUseCase(
            getit<ViewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => ChangeStatusOfferCubit(ChangeStatusOfferUseCase(
            getit<ViewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
          create: (context) => StatusOfferCubit(),
          child: ViewOfferBody(),
        ),
        BlocProvider(
          create: (context) => AddOfferCubit(AddOfferUseCase(
            getit<NewOfferRepoImpl>(),
          )),
        ),
        BlocProvider(
            create: (context) => SignInCubit(SignInUseCase(
                  getit.get<SignInRepoImpl>(),
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

        //for add product
        BlocProvider(
            create: (context) =>
                AddProductToStoreCubit(AddProductToStoreUseCase(
                  addProductStoreRepo: getit.get<AddProductStoreRepoImpl>(),
                ))),
        BlocProvider(create: (context) => AddImageToProductAddCubit()),
        BlocProvider(
            create: (context) =>
                GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
                  getit.get<AddProductStoreRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) =>
                GetBrandsByCategoryIdCubit(GetBrandsByMainCategoryIdUseCase(
                  getit.get<AddProductStoreRepoImpl>(),
                ))),
        BlocProvider(create: (context) => AddAttributeProductDartCubit()),
        //
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 1000),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: ThemeData(
            textTheme: GoogleFonts.cairoTextTheme(
              Theme.of(context).textTheme,
            ),
            useMaterial3: false,
            scaffoldBackgroundColor:
                const Color(0xFFF9F9F9), // Set default background color
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
