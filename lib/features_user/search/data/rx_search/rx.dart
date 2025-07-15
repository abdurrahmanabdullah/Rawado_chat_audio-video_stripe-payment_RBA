import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../networks/rx_base.dart';
import '../../../../features_trainer/home/model/all_service_model.dart';
import 'api.dart';

final class GetSeaarchRX extends RxResponseInt<AllServiceResponse> {
  final api = GetSearchApi.instance;

  GetSeaarchRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> search(String text) async {
    try {
      AllServiceResponse data = await api.search(searchQueary: text);
      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      // return
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      AllServiceResponse respose = data;
      log('ServiceResponse response: $respose');
      dataFetcher.sink.add(data);
      // ToastUtil.showLongToast(respose.message!);
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
    message = exception.response!.statusMessage!;
    if (error.type == DioExceptionType.connectionError) {
      message = "Check Your Network Connection";
    }
    // ToastUtil.showLongToast(message);
    dataFetcher.sink.addError(AllServiceResponse().copyWith(message: message));
    return false;
  }
}
