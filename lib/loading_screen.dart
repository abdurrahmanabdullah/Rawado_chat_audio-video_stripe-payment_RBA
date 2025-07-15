import 'package:flutter/material.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/features_user/auth/presentations/login/login_screen.dart';
import 'package:rawado/features_user/onboarding/presentations/onboarding_screen.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rawado/helpers/notification_service.dart';
import 'package:rawado/navigation_screen.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:rawado/trainer_navigation_sreen.dart';
import 'helpers/helper_methods.dart';
import 'networks/dio/dio.dart';
import 'welcome_screen.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    // AutoAppUpdateUtil.instance.checkAppUpdate();
    await Future.delayed(Durations.extralong2);
    await setInitValue();
    if (appData.read(kKeyIsLoggedIn)) {
      String token = appData.read(kKeyAccessToken);
      DioSingleton.instance.update(token);
      // Call Notification get token
      await LocalNotificationService.getToken();
      await getCategoriesRXObj.getCategories();
      await getProfileDetailsRXObj.getprofileDetails();
      // LocalNotificationService.getToken();
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const WelcomeScreen();
    } else {
      // return Container();
      return appData.read(kKeyIsLoggedIn)
          ? appData.read(kKeyRoleType) == kKeyISUser
              ? const NavigationScreen()
              : appData.read(kKeyRoleType) == kKeyISTrainer
                  ? const TrainerNavigationScreen()
                  : appData.read(kKeyIsFirstTime)
                      ? const OnboardingScreen()
                      : const LoginScreen()
          : appData.read(kKeyIsFirstTime)
              ? const OnboardingScreen()
              : const LoginScreen();
    }
  }
}
