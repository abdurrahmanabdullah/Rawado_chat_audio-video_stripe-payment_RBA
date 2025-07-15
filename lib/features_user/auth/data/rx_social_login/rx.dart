import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rawado/networks/dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/all_routes.dart';
import '../../../../helpers/navigation_service.dart';
import '/helpers/di.dart';
import '../../../../constants/app_constants.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/login_response.dart';
import 'api.dart';

final class PostSocialLoginRX extends RxResponseInt<LoginResponse> {
  final api = PostSocialLoginApi.instance;

  bool success = false;

  PostSocialLoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  String message = "";

  Future<void> socialLogin(
    String token,
  ) async {
    try {
      LoginResponse data = await api
          .socialLogin(
            token,
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
          log("=================");
          log('$userType id is >>>>>>>> $userId');
          log("=================");
          await appData.write(kKeyRoleType, userType);
          await appData.write(kKeyIsLoggedIn, true);
          await appData.writeIfNull(kKeyUserID, userId);
          await appData.write(kKeyAccessToken, accesstoken);
          dataFetcher.sink.add(loginResponse);
          ToastUtil.showLongToast(loginResponse.message!);
          DioSingleton.instance.update(accesstoken);
          // if (userType == kKeyISUser) {
          log("=========when Navigate========");
          log('$userType id is >>>>>>>> ${appData.read(kKeyUserID)}');
          log("=================");
          NavigationService.navigateToReplacement(Routes.navigationScreen);
          // } else if (userType == kKeyISTrainer) {
          //   log("=================");
          //   log('$userType id is >>>>>>>> ${appData.read(kKeyUserID)}');
          //   log("=================");
          //   NavigationService.navigateToReplacement(
          //       Routes.trainerNavigationScreen);
          // }
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
