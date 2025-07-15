import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../helpers/toast.dart';
import '../../../../networks/rx_base.dart';
import '../../model/available_response.dart';
import 'api.dart';

final class GetAvailableServiceRX
    extends RxResponseInt<AvailableServiceResponse> {
  final api = GetAvailableServiceApi.instance;

  bool success = false;

  GetAvailableServiceRX({required super.empty, required super.dataFetcher});

  ValueStream get getAvailableServiceData => dataFetcher.stream;

  String message = "";

  Future<void> getAvailableService(int id) async {
    try {
      AvailableServiceResponse data = await api.getAvailableServices(id);

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(AvailableServiceResponse data) async {
    try {
      AvailableServiceResponse response = data;
      log('Categories response: $response');
      dataFetcher.sink.add(data);
      if (response.data != null && response.data!.isNotEmpty) {
        dataFetcher.sink.add(response);
      } else {
        // Pass an empty response but include the message
        response.message = message; // Assign the message from the response
        dataFetcher.sink.add(response);
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  handleErrorWithReturn(error) {
    String message = 'Something went wrong';
    log(error.toString());
    if (error is DioException) {
      message = error.response?.data["message"] ?? "Something went wrong";
      int code = error.response?.data["code"] ?? -1;
      if (error.type == DioExceptionType.connectionError) {
        message = "Check Your Network Connection";
      }
      log("Error: $message, Code: $code");
    }
    ToastUtil.showLongToast(message);

    // log('error.runtimeType${error.runtimeType}');
    // DioException exception = error as DioException;
    // // if(error is DioException)
    // log(exception.message.toString());
    // log(exception.response!.statusCode!.toString());
    // message = exception.response!.data["message"];
    // // ToastUtil.showLongToast(message);
    // dataFetcher.sink.addError(message);
    // return message;
  }
}
