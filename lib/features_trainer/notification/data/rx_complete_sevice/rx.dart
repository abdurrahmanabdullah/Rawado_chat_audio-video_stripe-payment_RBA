import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class PostUserSessionCompleteActionRX extends RxResponseInt {
  final api = PostUserSessionCompleteActionApi.instance;

  PostUserSessionCompleteActionRX(
      {required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> completeSession(int id) async {
    try {
      Map data = await api.completeSession(id: id);
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
      log('ServiceResponse response: $data');
      dataFetcher.sink.add(data);
      ToastUtil.showLongToast(data.message!);
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
    message = exception.response!.data["message"];
    ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(error);
    return false;
  }
}
