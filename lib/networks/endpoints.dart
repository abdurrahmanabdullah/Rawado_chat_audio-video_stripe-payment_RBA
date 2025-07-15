// ignore_for_file: constant_identifier_names
// const String url = 'https://rawado.reigeeky.com';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String? url = dotenv.env['API_BASE_URL']!;

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class PaymentGateway {
  PaymentGateway._();
  static String gateway(String orderId) =>
      "https://demo.vivapayments.com/web/checkout?ref={$orderId}";
}

final class Endpoints {
  Endpoints._();
  //backend_url
  // App Url

  static String signUp() => "/api/register";
  static String logIn() => "/api/login";
  static String socialLogin() => "/api/social-login";
  static String logout() => "/api/logout";
  static String forgotPasswordEmail() => "/api/forget-password";
  static String forgotPassword() => "/api/forgot-password";
  static String resetPassword() => "/api/reset-password";
  static String verifyOtpFP() => "/api/verify-otp";
  static String serviceCreate() => "/api/trainer/service/store";
  static String categories() => "/api/categories";
  static String serviceDetails(int id) => "/api/trainer/service/show/$id";
  static String scheduleCreate() => "/api/trainer/service/available/store";
  static String profileDetails() => "/api/me";
  static String customerAllService() => "/api/customer/service";
  static String trainerAllService() => "/api/trainer/service";
  static String signleService(int id) => "/api/customer/service/show/$id";
  static String availableService(int id) =>
      "/api/trainer/service/available/$id";
  static String booking(int id) => "/api/customer/booking/store/$id";
  static String reSchedule(int id) => "/api/customer/reschedule/update/$id";
  static String customerHistory() => "/api/customer/schedule/history";
  static String bookSchedule() => "/api/customer/schedule/booked";
  static String pendingSchedule() => "/api/customer/schedule/pending";
  static String getTrainerBookingList() => "/api/trainer/schedule/history";

  static String trainerBookingAction(int id) =>
      "/api/trainer/schedule/single/$id";

  static String trainerRescheduleAction(int id) =>
      "/api/trainer/reschedule/status/$id";

  static String completeServie(int id) =>
      "/api/trainer/schedule/confirm/request/send/$id";

  static String updateProfile() => "/api/update-profile";

  static String changePassword() => "/api/settings/password-reset";

  static String customerGiveReview() => "/api/customer/review/store";

  static String paymentIntent() => "/api/payment/intent";

  static String tapPayment() => "/api/create-charge";

  static String userReview(int page) => "/api/trainer/review?page=$page";

  static String trainerRating() => "/api/trainer/review/percent";

  static String customerSearch(String queary) =>
      "/api/customer/service/search?search=$queary";

  static String messageList() => "/api/messages/all";

  static String sendMessage(int id) => "/api/messages/send/$id";

  static String reciveMessage(int id) => "/api/messages/receive/$id";

  static String messageRoom(int id) => "/api/messages/group/$id";

  static String notification() => "/api/notify";

  static String earningUrl() =>
      "/api/trainer/earning?year=2024&month=11&day=11";

  static String addToken() => "/api/firebase/token/add";

  static String completeSession(int id) => "/api/customer/schedule/confirm/$id";

  static String getScheduleTime(int id, String date) => "/api/customer/service/booking/data?service_id=$id&date=$date";

  // Customer API Url
}
