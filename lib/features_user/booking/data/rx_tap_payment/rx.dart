import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import 'api.dart';

final class TapPaymentRX extends RxResponseInt<String> {
  final api = TapPaymentApi.instance;

  TapPaymentRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<String> tapPayment(Map body) async {
    try {
      String data = await api.tapPayment(body: body);
      // .waitingForFuture();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      // return
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      String respose = data;
      log('ServiceResponse response: $respose');
      dataFetcher.sink.add(data);
      // ToastUtil.showLongToast('');
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
