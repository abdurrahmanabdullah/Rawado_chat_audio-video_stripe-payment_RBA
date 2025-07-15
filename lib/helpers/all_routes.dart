import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:rawado/features_trainer/earning/presentation/earning_screen.dart';
import 'package:rawado/features_trainer/home/model/all_service_model.dart';
import 'package:rawado/features_trainer/notification/presentation/notification_screen.dart';
import 'package:rawado/features_trainer/review/presentaion/trainer_review_screen.dart';
import 'package:rawado/features_trainer/schedule/model/trainer_booking_list.dart';
import 'package:rawado/features_trainer/schedule/presentation/booking_request_summary_screen.dart';
import 'package:rawado/features_trainer/service/presentation/service_add_screen.dart';
import 'package:rawado/features_trainer/service/presentation/service_details_screen.dart';
import 'package:rawado/features_user/auth/presentations/sign_up/sign_up_screen.dart';
import 'package:rawado/features_user/booking/presentation/add_card_screen.dart';
import 'package:rawado/features_user/booking/presentation/booking_schedule.dart';
import 'package:rawado/features_user/booking/presentation/booking_summary_screen.dart';
import 'package:rawado/features_user/home/presentations/see_all.dart';
import 'package:rawado/features_user/massage/presentation/massage_inbox_screen.dart';
import 'package:rawado/features_user/profile/model/profile_details_model.dart';
import 'package:rawado/features_user/profile/presentation/edit_profile_screen.dart';
import 'package:rawado/features_user/profile/presentation/my_wallet_screen.dart';
import 'package:rawado/features_user/profile/presentation/select_theme_screen.dart';
import 'package:rawado/features_user/ratting/presentation/review_screen.dart';
import 'package:rawado/features_user/schedule/presentation/appointment_history_screen.dart';
import 'package:rawado/features_user/schedule/presentation/appointment_screen.dart';
import 'package:rawado/features_user/schedule/presentation/re_schedule_booking.dart';
import 'package:rawado/features_user/search/presentation/gps_search_screen.dart';
import 'package:rawado/features_user/search/presentation/manually_search_screen.dart';
import 'package:rawado/features_user/settings/presentations/change_password_screen.dart';
import 'package:rawado/features_user/settings/presentations/privacy_policy_screen.dart';
import 'package:rawado/features_user/settings/presentations/settings_screen.dart';
import 'package:rawado/features_user/trainer_details/presentation/trainer_details_screen.dart';
import 'package:rawado/loading_screen.dart';
import 'package:rawado/navigation_screen.dart';
import 'package:rawado/role_screen.dart';
import 'package:rawado/trainer_navigation_sreen.dart';

import '../features_user/auth/presentations/login/login_screen.dart';
import '../features_user/booking/presentation/select_card_screen.dart';
import '../features_user/home/presentations/home_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  static const String roleScreen = '/roleScreen';
  static const String logInScreen = '/logIn';
  static const String signUpScreen = '/signUp';
  static const String home = '/home';
  static const String navigationScreen = '/navigationScreen';
  static const String navigationScreenWithArgs = '/navigationScreenWithArgs';
  static const String navigatonProfileScreen = '/navigatonProfileScreen';
  static const String trainerNavigationScreen = '/trainerNavigationScreen';
  static const String manuallySearch = '/manuallySearch';
  static const String gpsSearch = '/gpsSearch';
  static const String trainerDetails = '/trainerDetails';
  static const String bookingSummary = '/bookingSummary';
  static const String selectCard = '/selectCard';
  static const String addCardScreen = '/addCardScreen';
  static const String editProfile = '/editProfile';
  static const String reScheduleBokking = '/reScheduleBokking';
  static const String appointment = '/appointment';
  static const String appointmentHistory = '/appointmentHistory';
  static const String reviewScreen = '/reviewScreen';
  static const String settings = '/settings';
  static const String changePassword = '/changePassword';
  static const String massageInbox = '/massageInbox';
  static const String privacyPolecy = '/privacyPolecy';
  static const String addService = '/addService';
  static const String details = '/details';
  static const String serviceDetails = '/serviceDetails';
  static const String bookingRequestSummary = '/bookingRequestSummary';
  static const String notification = '/notification';
  static const String trainerReviewScreen = '/trainerReviewScreen';
  static const String earningScreen = '/earningScreen';
  static const String selectTheme = '/selectTheme';
  static const String loading = '/loading';
  static const String boookingSchedule = '/boookingSchedule';
  static const String seeAll = '/seeAll';
  static const String myWallet = '/myWallet';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();
  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.roleScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: RoleScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const RoleScreen());

      case Routes.logInScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: LoginScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const LoginScreen());

      case Routes.signUpScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: SignUpScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const SignUpScreen());

      case Routes.loading:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: Loading()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const Loading());

      case Routes.home:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: HomeScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const HomeScreen());

      case Routes.navigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: NavigationScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen());

      case Routes.trainerNavigationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: TrainerNavigationScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const TrainerNavigationScreen());

      case Routes.manuallySearch:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: ManuallySearchScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ManuallySearchScreen());

      case Routes.trainerDetails:
        final args = settings.arguments as ServiceData;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: TrainerDetailsScreen(serviceData: args)),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TrainerDetailsScreen(serviceData: args));

      case Routes.bookingSummary:
        final args = settings.arguments as bool?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: BookingSummaryScreen(
                  isReSchedule: args!,
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) =>
                    BookingSummaryScreen(isReSchedule: args!));

      case Routes.selectCard:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: SelectCardScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SelectCardScreen());

      case Routes.addCardScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: AddCardScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const AddCardScreen());

      case Routes.gpsSearch:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: GPSSearchScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const GPSSearchScreen());

      case Routes.editProfile:
        final args = settings.arguments as ProfileData;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: EditProfileScreen(
                  profile: args,
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => EditProfileScreen(
                      profile: args,
                    ));

      case Routes.reScheduleBokking:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: ReScheduleBooking()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ReScheduleBooking());

      case Routes.appointment:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: AppointmentScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AppointmentScreen());

      case Routes.appointmentHistory:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: AppointmentHistoryScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const AppointmentHistoryScreen());

      case Routes.reviewScreen:
        final args = settings.arguments as int?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: ReviewScreen(
                  serviceId: args,
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ReviewScreen(
                      serviceId: args,
                    ));

      case Routes.settings:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: SettingsScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const SettingsScreen());

      case Routes.changePassword:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: ChangePasswordScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ChangePasswordScreen());
      case Routes.privacyPolecy:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: PrivacyPolicyScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const PrivacyPolicyScreen());

      case Routes.massageInbox:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: MassageInboxScreen(
                  id: args["id"],
                  name: args["name"],
                  image: args["image"],
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => MassageInboxScreen(
                      id: args["id"],
                      name: args["name"],
                      image: args["image"],
                    ));

      case Routes.addService:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: ServiceAddScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const ServiceAddScreen());
      // case Routes.details:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const ScreenTitle(widget: DetailsScreen()),
      //           settings: settings)
      //       : CupertinoPageRoute(builder: (context) => const DetailsScreen());
      case Routes.bookingRequestSummary:
        final args = settings.arguments as TrainerBookingData;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: TrainerBookingRequestSummaryScreen(
                  bookingData: args,
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => TrainerBookingRequestSummaryScreen(
                      bookingData: args,
                    ));

      case Routes.notification:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: NotificationScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NotificationScreen());

      case Routes.trainerReviewScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: TrainerReviewScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const TrainerReviewScreen());

      case Routes.earningScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: EarningScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const EarningScreen());

      case Routes.selectTheme:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: SelectThemeScreen()),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const SelectThemeScreen());

      case Routes.myWallet:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: MyWalletScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const MyWalletScreen());

      case Routes.boookingSchedule:
        final args = settings.arguments as bool;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: BookingScheduleScreen(
                  isReSchedule: args,
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => BookingScheduleScreen(
                      isReSchedule: args,
                    ));

      case Routes.serviceDetails:
        final args = settings.arguments as int?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: ScreenTitle(
                    widget: ServiceDetailsScreen(
                  id: args,
                )),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => ServiceDetailsScreen(
                      id: args,
                    ));

      case Routes.seeAll:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const ScreenTitle(widget: SeeAllScreen()),
                settings: settings)
            : CupertinoPageRoute(builder: (context) => const SeeAllScreen());

      case Routes.navigationScreenWithArgs:
        // final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavigationScreen(
                  isSelectIndex: true,
                  selectIndex: 1,
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen(
                      isSelectIndex: true,
                      selectIndex: 1,
                    ));

      case Routes.navigatonProfileScreen:
        // final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: const NavigationScreen(
                  isSelectIndex: true,
                  selectIndex: 4,
                ),
                settings: settings)
            : CupertinoPageRoute(
                builder: (context) => const NavigationScreen(
                      isSelectIndex: true,
                      selectIndex: 4,
                    ));

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
