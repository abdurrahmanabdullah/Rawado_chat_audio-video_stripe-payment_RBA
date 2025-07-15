//azad added ...

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import '../../model/customer_schedule_response.dart';
import 'api.dart';

final class GetBookedScheduleRX
    extends RxResponseInt<CustomerScheduleResponse> {
  final api = GetCustomerScheduleApi.instance;

  bool success = false;

  GetBookedScheduleRX({required super.empty, required super.dataFetcher});

  ValueStream get getserrviceCreateData => dataFetcher.stream;

  String message = "";

  Future<void> getBookedSchedule() async {
    try {
      CustomerScheduleResponse data = await api.getBookedSchedule();

      // .waitingForFuture();
      return handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(CustomerScheduleResponse data) async {
    try {
      CustomerScheduleResponse respose = data;
      log('Profile details response: $respose');
      dataFetcher.sink.add(data);
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

    //return super.handleErrorWithReturn(message);
  }

  // @override
  // handleErrorWithReturn(error) {
  //   log('error.runtimeType${error.runtimeType}');
  //   DioException exception = error as DioException;
  //   // if(error is DioException)
  //   log(exception.message.toString());
  //   log(exception.response!.statusCode!.toString());
  //   message = exception.response!.data["message"];
  //   ToastUtil.showLongToast(message);
  //   dataFetcher.sink.addError(error);
  //   return message;
  // }
}
