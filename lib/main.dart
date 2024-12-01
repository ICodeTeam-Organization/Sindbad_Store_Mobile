import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/auth_features/data/repos_impl/sign_in_repo_impl.dart';
import 'package:sindbad_management_app/features/auth_features/domain/usecases/sign_in_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/order_invoice_usecasse.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/order_details/order_details_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/refresh/refresh_page_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/invoice/order_invoice_cubit.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/screen/order_details.dart';

import 'core/setup_service_locator.dart';
import 'core/simple_bloc_observer.dart';
import 'features/auth_features/ui/manager/cubit/sign_in_cubit.dart';
import 'features/order_management _features/domain/usecases/order_details_usecase.dart';

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
            create: (context) => SignInCubit(SignInUseCase(
                  getit.get<SignInRepoImpl>(),
                ))),
        BlocProvider(create: (context) => RefreshPageCubit()),
        BlocProvider(
            create: (context) => OrderInvoiceCubit(OrderInvoiceUsecase(
                  allOrderRepo: getit.get<AllOrderRepoImpl>(),
                ))),
        BlocProvider(
            create: (context) => OrderDetailsCubit(OrderDetailsUsecase(
                  getit.get<AllOrderRepoImpl>(),
                ))),
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
