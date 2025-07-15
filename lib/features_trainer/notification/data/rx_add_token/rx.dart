import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rawado/helpers/toast.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostAddTokenRx extends RxResponseInt {
  final api = PostAddTokenApi.instance;

  String message = "Something went wrong";

  PostAddTokenRx({required super.empty, required super.dataFetcher});

  ValueStream get postAddToke => dataFetcher.stream;

  Future<bool> addToken(Map data) async {
    try {
      Map resdata = await api.addToken(data);
      return await handleSuccessWithReturn(resdata);
    } catch (error) {
      return await handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    dataFetcher.sink.add(data);

    return true;
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";

      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
    }
    ToastUtil.showLongToast(message);
    // CustomToastMessage('Error', message);
    return false;
  }
}
