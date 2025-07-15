//azad added ...

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class PostUpdateProfileRX extends RxResponseInt<Map> {
  final api = PostUpdateProfileApi.instance;

  bool success = false;

  PostUpdateProfileRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> updateProfile({required Map<String, dynamic> body}) async {
    try {
      Map data = await api.updateProfile(body: body);

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      Map respose = data;
      await appData.writeIfNull(kKeyUserName, data["data"]!["name"]);
      ToastUtil.showLongToast(data["message"]);
      log('Profile Update response: $respose');
      dataFetcher.sink.add(data);
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
    return message;
  }
}
