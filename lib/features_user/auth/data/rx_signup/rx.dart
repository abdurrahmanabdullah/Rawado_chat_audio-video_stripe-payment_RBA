// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:rawado/features_user/auth/presentations/login/login_screen.dart';
import 'package:rawado/helpers/loading_helper.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/signup_response.dart';
import 'api.dart';

final class PostSignUpRX extends RxResponseInt<SignUpResponse> {
  final api = SignUpApi.instance;

  PostSignUpRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;
  String message = "";
  Future<bool> signup({
    required String firstName,
    required String email,
    required String password,
    required String password_confirmation,
    required String phone,
    required String role,
    required String gender,

  }) async {
    try {
      SignUpResponse data = await api
          .signUp(
              name: firstName,
              email: email,
              password: password,
              phone: phone,
              role: role,
              retypePw: password_confirmation,
              gender:gender
              
              )
          .waitingForFuture();
      return await handleSuccessWithReturn(data);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    SignUpResponse signUpRes = data;
    // log(signUpRes.toString());
    if (signUpRes.status!) {
      // String accesstoken = _signUpRes.token!;
      // log('accesstoken');
      // await appData.write(kKeyAccessToken, accesstoken);
      // DioSingleton.instance.update(accesstoken);
      dataFetcher.sink.add(data);
      message = signUpRes.message!;
      ToastUtil.showLongToast(message);
      // NavigationService.navigateToReplacement(Routes.logInScreen);

      Get.offAll(const LoginScreen());
      log('HA HA HA HA');
      // NavigationService.navigateToUntilReplacementWithObject(
      //     Routes.otpVerify, true);
      return true;
    } else {
      return false;
    }
  }

  @override
  handleErrorWithReturn(error) {
    log(error.runtimeType.toString());
    DioException exception = error as DioException;
    log(exception.message.toString());
    message = exception.response!.data["message"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return false;
  }
}
