import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import '../../../../helpers/di.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class VerifyOtpFPRX extends RxResponseInt {
  final api = VerifyOtpFpApi.instance;

  VerifyOtpFPRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;
  String message = "Otp verification not successful.";
  Future<bool> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      Map data = await api.verifyOtp(
        email: email,
        code: code,
      );
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(error) {
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }

  @override
  handleSuccessWithReturn(data) {
    dataFetcher.sink.add(data);
    message = data["message"];
    appData.write('tokenFP', data["token"] ?? '');

    if (data["status"] == false) {
      throw Exception();
    }
    return true;
  }
}
