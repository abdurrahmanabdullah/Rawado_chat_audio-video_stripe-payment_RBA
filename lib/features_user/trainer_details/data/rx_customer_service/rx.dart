import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/single_service_response.dart';
import 'api.dart';

final class GetSingleServicesRx extends RxResponseInt<SingleServiceResponse> {
  final api = GetSingleServicesApi.instance;

  bool success = false;

  GetSingleServicesRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream get getSingleServicesData => dataFetcher.stream;

  String message = "";

  Future<void> getSingleServices(int id) async {
    try {
      SingleServiceResponse data = await api.getSignleServices(id);

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(data) async {
    try {
      SingleServiceResponse respose = data;
      log('Categories response: $respose');
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
