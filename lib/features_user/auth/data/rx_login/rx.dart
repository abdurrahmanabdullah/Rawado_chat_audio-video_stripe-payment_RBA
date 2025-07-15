import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '../../../../helpers/notification_service.dart';
import '/helpers/di.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/login_response.dart';
import 'api.dart';

final class GetLoginRX extends RxResponseInt<LoginResponse> {
  final api = LoginApi.instance;

  bool success = false;

  GetLoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  String message = "";

  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      LoginResponse data = await api
          .login(
            email,
            password,
          )
          .waitingForFuture();

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(LoginResponse data) async {
    try {
      LoginResponse loginResponse = data;
      log('login response: $loginResponse');
      // if (loginResponse.code == 203) {
      //   ToastUtil.showLongToast(loginResponse.message ?? '');
      //   // await resendOtpRxObj.resendOtp(
      //   //     email: await appData.read(
      //   //   kKeyEmail,
      //   // ));
      //   // NavigationService.navigateToUntilReplacementWithObject(
      //   //     Routes.otpVerify, true);
      // } else
      if (loginResponse.code == 200) {
        if (loginResponse.status == true) {
          String accesstoken = loginResponse.token!;
          String userId = loginResponse.data!.id!.toString();
          String userType = loginResponse.data!.role!;

          // Set Role, ISlogin, user id , accesstoken
          await appData.write(kKeyRoleType, userType);
          await appData.write(kKeyIsLoggedIn, true);
          await appData.writeIfNull(kKeyUserID, userId);
          await appData.write(kKeyAccessToken, accesstoken);

          // Add data to Stream
          dataFetcher.sink.add(loginResponse);

          // Show Toast Messaage
          ToastUtil.showLongToast(loginResponse.message!);

          // Updaate Dio Token
          DioSingleton.instance.update(accesstoken);

          // Call Notification get token
          await LocalNotificationService.getToken();

          if (userType == kKeyISUser) {
            // Is user then loginn to user navigation screen
            NavigationService.navigateToReplacement(Routes.navigationScreen);
          } else if (userType == kKeyISTrainer) {
            // Is trainer then loginn to trainer navigation screen
            NavigationService.navigateToReplacement(
                Routes.trainerNavigationScreen);
          }
        } else {
          await appData.write(kKeyIsLoggedIn, false);
          ToastUtil.showLongToast(loginResponse.message!);
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    log('error.runtimeType${error.runtimeType}');
    DioException exception = error as DioException;
    // if(error is DioException)
    log(exception.message.toString());
    log(exception.response!.statusCode!.toString());
    message = exception.response!.data["message"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return false;
  }
}
