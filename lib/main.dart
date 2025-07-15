import 'package:auto_animated/auto_animated.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:rawado/firebase_options.dart';
import 'package:rawado/loading_screen.dart';

import '/helpers/all_routes.dart';
import 'constants/custome_theme.dart';
import 'gen/colors.gen.dart';
import 'helpers/di.dart';
import 'helpers/helper_methods.dart';
import 'helpers/navigation_service.dart';
import 'helpers/notification_service.dart';
import 'helpers/register_provider.dart';
import 'networks/dio/dio.dart';

Future<void> backgroundHandler(RemoteMessage message) async {}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: "assets/.env");
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLIC_KEY']!;
  await Stripe.instance.applySettings();
  // await FlutterDisplayMode.setHighRefreshRate();

  await GetStorage.init();
  diSetup();
  initiInternetChecker();
  DioSingleton.instance.create();
  // await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    rotation();
    setInitValue();

    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: PopScope(
          canPop: true,
          onPopInvokedWithResult: (bool didPop, result) async {
            showMaterialDialog(context);
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return const UtillScreenMobile();
            },
          ),
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // String language = appData.read(kKeyLanguage);
    // String countryCode = appData.read(kKeyCountryCode);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (bool didPop, result) async {
            showMaterialDialog(context);
          },
          child: GetMaterialApp(
              // showPerformanceOverlay: true,
              theme: ThemeData(
                  primarySwatch: CustomTheme.kToPurple,
                  useMaterial3: false,
                  scaffoldBackgroundColor: AppColors.scaffoldColor),
              darkTheme: ThemeData(
                  primarySwatch: CustomTheme.kToBlue,
                  useMaterial3: false,
                  scaffoldBackgroundColor: AppColors.scaffoldColor),
              debugShowCheckedModeBanner: false,
              // translations: LocalString(),
              // locale: Locale(language, countryCode),
              builder: (context, widget) {
                return MediaQuery(data: MediaQuery.of(context), child: widget!);
              },
              navigatorKey: NavigationService.navigatorKey,
              onGenerateRoute: RouteGenerator.generateRoute,
              home: const Loading()),
        );
      },
    );
  }
}
