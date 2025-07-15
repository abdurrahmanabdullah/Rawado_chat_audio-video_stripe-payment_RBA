import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostChangePasswordRX extends RxResponseInt<Map> {
  final api = PostChangePasswordApi.instance;

  PostChangePasswordRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> changePW(Map body) async {
    try {
      Map data = await api.changePW(body: body);
      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      // return
      handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      Map respose = data;
      log('ServiceResponse response: $respose');
      dataFetcher.sink.add(data);
      ToastUtil.showLongToast(respose["data"]);
      return data;
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
    message = exception.response!.data["data"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return false;
  }
}
